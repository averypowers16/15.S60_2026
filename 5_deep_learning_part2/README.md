# Pre-assignment 5 (Before Session)

Feel free to reach out to me (natashap@mit.edu) if you have any questions. Have fun!

<ins>**Submit to Canvas**</ins> 

A single PDF containing the following:

    (1) A screenshot of the final output from the Ollama section in the pre-assignemnt notebook in Step 4.

    (2) A screenshot of the final output from the Hugging Face section in the pre-assignment notebook in Step 5.

    (3) A screenshot of the final output from the Wikipedia API section in the pre-assignment notebook in Step 6.

**OPTIONAL**: It is good practice to create a virtual environment for each project you work on. A virtual environment isolates that project’s Python packages from the rest of your system, which helps avoid version conflicts and makes your setup easier to reproduce. You can activate the environment when you are working on this project and deactivate it when you are done.

Before running any of the pre-assignment code (which will install packages from requirements.txt), you can create a virtual environment, if you're comfortable/ familiar with how to do so: https://python.land/virtual-environments/virtualenv. 


## Instructions

1. Ollama is an open-source platform for using locally installed LLMs and interacting with these models programmatically. Download the Ollama installation package for your operating system here: https://ollama.com/download. Follow the on-screen instructions to install Ollama on your local machine. 

2. The following user interface should pop up immediately after installation. But no worries if it doesn't - you can open the Ollama app by finding it in your applications folder (macOS) or from the Start menu (Windows): 

![Image of Ollama User Interface](ollamaUI.png)

3. Click on the drop-down menu for model selection (circled in red in the screenshot above) and click "gemma3:1b" (this is a smaller model with 1 Billion parameters that doesn't require a lot of memory or computational resources). Then enter a simple question into the chat box and hit enter. The gemma3 model will first download, and then an answer to your query will be returned.

This is a nice chat-window interface for interacting with your downloaded AI models. But we also want more low-level control to integrate these models into our workflows. Let's go ahead and try it out!

4. Run the Ollama section of the pre-assignment Jupyter Notebook (Pre-assignment 5.ipynb). This will help you get started with Ollama models in Python. In our session, we'll look at more advanced uses, along with downloading + running models from the CLI.

5. Hugging Face hosts a large online repository of pre-trained models. Their Transformers library provides convenient APIs for loading and fine-tuning state-of-the-art models. The Transformers library works with PyTorch, which also provides more low-level control over building and training our own deep learning models from scratch. Run the Hugging Face section of the pre-assignment Jupyter Notebook (Pre-assignment 5.ipynb) to make sure you have everything installed and ready.

Each pre-trained model on Hugging Face should have an accompanying "model card" - which is a document that contains information on the model's architecture, intended use, training data & procedure, performance metrics, limitations, etc. 

If you're curious, here's the model card for bert-base-uncased: https://huggingface.co/google-bert/bert-base-uncased 

6. Wikipedia API as a free, reliable way for our AI agents to look up information. The API lets our code programmatically search Wikipedia and retrieve clean text from pages. To enable this, open the .env file in this GitHub repository and enter your MIT email address in the YOUR_EMAIL field. Then, run the Wikipedia API section of the pre-assignment Jupyter notebook (Pre-assignment 5.ipynb). If everything is working, the notebook should successfully connect to Wikipedia and print the introduction of the Boston page.

**OPTIONAL**: If you would like to experiment with commercial, cloud-hosted models, you can create an OpenAI account and generate an API key at https://platform.openai.com/account/api-keys. If you place this key in the .env file for this project, the code will be able to call OpenAI’s hosted models through the OpenAI API. But please note that using OpenAI’s API is NOT needed for this workshop. All demos work with the open-source and locally hosted models we access via Hugging Face and Ollama. If you do choose to use OpenAI’s models, be aware that they are billed per token based on the specific model you select. You can review the current pricing here: https://platform.openai.com/docs/pricing. 


## A Note on CPU vs GPU (CUDA) Support

PyTorch can run on either your CPU or, if available, an NVIDIA GPU using CUDA. GPUs are designed for parallel computation, which makes them much faster than CPUs for the large matrix operations used in deep learning. CUDA is NVIDIA’s programming platform for GPUs that allows software like PyTorch to run computations directly on the graphics card. 

All of the code in this project works on CPU-only machines (i.e. - all of your laptops), but training and large-model inference in some of the demos will run significantly more slowly without a GPU.

**OPTIONAL**: If you already know how to access to a compatible NVIDIA GPU, you can install a CUDA-enabled version of PyTorch using "requirements-gpu.txt" (but you may have to change the CUDA version) in place of the default "requirements-cpu.txt" file. Otherwise, follow the default CPU-based installation in the pre-assignment notebook and everything will still run correctly. 


# Homework Assignment 5 (After Session)

Be sure to use GPU for the Google Colab assignment. For the actual training loop - I don't expect it to take more than 20 mins for the currently recommended training arguments, number of training samples, and number of epochs. Reach out to me (natashap@mit.edu) if it exceeds 30 minutes.

<ins>**Submit to Canvas**</ins> 

    (1) [Estimated Time to Complete: 10 mins] The Jupyter Notebook "4- Prompt Engineering.ipynb" after running all of the code cells with output visible

    (2) [Estimated Time to Complete: 2-3 Hours] A completed copy of the following Google Colab Notebook: https://colab.research.google.com/drive/1VEVr_6A7VwbxhLezR804ID-z4V8qpkVh?usp=sharing 








