# Running a Docker Image on a Cluster Using Singularity

This guide shows how to allocate a compute node on Engaging, pull a Docker image using Singularity, and launch a VM-like interactive environment from it.

---

## 0. Building the image
I won't cover how you can build a Docker image and push it to DockerHub, since there are infinite resources on the internet about it.

The way I did it is that I built the image on my computer (using the Docker app), and then uploaded the image into DockerHub. 

You can probably build it directly in Engaging (since singularity/apptainer have very similar functionalities as Docker), although you should be aware of space limits.

## 1. Allocate Resources on the Cluster

Start an interactive job on a compute node with GPU resources:

```bash
srun --pty \
     --partition=mit_normal_gpu \
     --gres=gpu:1 \
     --mem=32G \
     --time=02:00:00 \
     bash
```

---

## 2. Load Singularity

```bash
module load singularity
```
Note that some nodes, instead of singularity use `apptainer` so you might needto used that instead.

---

## 3. Pull Docker Image via Singularity

Convert a Docker image from Docker Hub into a Singularity image file (.sif):

```bash
singularity pull img.sif docker://margaeor/vllm:0.2
```

This creates a portable image file called `img.sif` which you can keep and also share it with others if you have a shared folder in Engaging.

You need to do this step **only ONCE**. If you  have already created your `img.sif`, you can simply proceed to Step 4 without repeating this step.

This specific image is an image I have created to support vLLM, which is a very fast wrapper for LLMs, which increases LLM inference time by more than 10x (compared to transformers/hugginface).

---

## 4. Launch VM-like Environment from the Image

Start an interactive shell inside the image with GPU support and your home directory mounted:

```bash
singularity shell --nv -H /home/<user>:/home ./img.sif
```

You are now inside a VM-like environment spawned from the Docker image.

## 5. Launch VM-like Environment from the Image
You can now do `cd /home` and go to the home directory insited the VM (which we mapped to your user home directory in Engaging).

First run `nvidia-smi` to check your GPU resources. Then go to the folder where this `Readme.md` exists and simply run:
```bash
python3 vllm_test.py
```
This script compares the speed of using the vLLM wrapper to do vLLM inference, against using the transformer/hugginface API.
---

## Author Information

- **Name:** Georgios Margaritis  
- **Affiliation:** MIT ORC  
- **Email:** geomar\<at\>mit.edu