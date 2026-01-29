import time
import gc
import psutil
import torch
import pandas as pd
from tqdm import tqdm

from transformers import AutoTokenizer, AutoModelForCausalLM
from vllm import LLM, SamplingParams


# =========================
# CONFIG
# =========================
MODEL_NAME = "HuggingFaceTB/SmolLM-360M-Instruct"
PROMPT_CSV = "./llm_prompts_100.csv"   # must contain column "prompt"
N_PROMPTS = 100                        # number of prompts to benchmark
BATCH_SIZE = 32
MAX_NEW_TOKENS = 256
DTYPE = torch.float16


# =========================
# UTILS
# =========================
def get_memory_usage():
    gpu = torch.cuda.memory_allocated() / 1024**3 if torch.cuda.is_available() else 0
    cpu = psutil.virtual_memory().used / 1024**3
    return gpu, cpu


def load_prompts():
    df = pd.read_csv(PROMPT_CSV)
    return df["prompt"].tolist()[:N_PROMPTS]


# =========================
# HUGGINGFACE INFERENCE
# =========================
def hf_batched_inference(prompts):
    print("\n" + "=" * 50)
    print("HUGGINGFACE TRANSFORMERS")
    print("=" * 50)

    tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token

    model = AutoModelForCausalLM.from_pretrained(
        MODEL_NAME,
        torch_dtype=DTYPE,
        device_map="auto",
    )
    model.eval()

    torch.cuda.synchronize()
    start = time.time()

    outputs_all = []

    for i in tqdm(range(0, len(prompts), BATCH_SIZE)):
        batch = prompts[i : i + BATCH_SIZE]

        inputs = tokenizer(
            batch,
            return_tensors="pt",
            padding=True,
            truncation=True,
        ).to(model.device)

        with torch.no_grad():
            outputs = model.generate(
                **inputs,
                max_new_tokens=MAX_NEW_TOKENS,
                temperature=0.7,
                top_p=0.9,
                do_sample=True,
                pad_token_id=tokenizer.eos_token_id,
            )

        for j, out in enumerate(outputs):
            gen = out[inputs["input_ids"].shape[1]:]
            outputs_all.append(tokenizer.decode(gen, skip_special_tokens=True))

    torch.cuda.synchronize()
    end = time.time()

    gpu, cpu = get_memory_usage()
    print(f"HF time: {end - start:.2f}s")
    print(f"Avg / prompt: {(end - start)/len(prompts):.3f}s")
    print(f"GPU: {gpu:.2f} GB | CPU: {cpu:.2f} GB")

    del model
    torch.cuda.empty_cache()
    gc.collect()

    return outputs_all, end - start


# =========================
# VLLM INFERENCE
# =========================
def vllm_inference(prompts):
    print("\n" + "=" * 50)
    print("VLLM")
    print("=" * 50)

    llm = LLM(
        model=MODEL_NAME,
        dtype="half",
        trust_remote_code=True,
        gpu_memory_utilization=0.9,
        max_model_len=2048,
    )

    sampling_params = SamplingParams(
        temperature=0.7,
        top_p=0.9,
        max_tokens=MAX_NEW_TOKENS,
    )

    # warmup
    llm.generate(prompts[:2], sampling_params)
    torch.cuda.synchronize()

    start = time.time()
    outputs = llm.generate(prompts, sampling_params)
    torch.cuda.synchronize()
    end = time.time()

    texts = [o.outputs[0].text for o in outputs]

    gpu, cpu = get_memory_usage()
    print(f"vLLM time: {end - start:.2f}s")
    print(f"Avg / prompt: {(end - start)/len(prompts):.3f}s")
    print(f"GPU: {gpu:.2f} GB | CPU: {cpu:.2f} GB")

    return texts, end - start


# =========================
# MAIN
# =========================
def main():
    prompts = load_prompts()
    print(f"Loaded {len(prompts)} prompts")

    vllm_out, vllm_time = vllm_inference(prompts)
    hf_out, hf_time = hf_batched_inference(prompts)

    print("\n" + "=" * 60)
    print("SPEED COMPARISON")
    print("=" * 60)

    print(f"vLLM: {vllm_time:.2f}s")
    print(f"HF  : {hf_time:.2f}s")
    print(f"Speedup (HF / vLLM): {hf_time / vllm_time:.2f}×")

    if hf_time > vllm_time:
        print("✅ vLLM is faster")
    else:
        print("⚠️ HF is faster (unexpected for large batches)")


if __name__ == "__main__":
    main()