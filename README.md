# LlamaLibrary

A .NET class library for running inference using LLamaSharp. This repository includes a PowerShell script (run-inference.ps1) to interact with the library and perform inference tasks.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup - Step 1: Clone the Repository](#setup---step-1-clone-the-repository)
- [Setup - Step 2: Build the Project](#setup---step-2-build-the-project)
- [Setup - Step 3: Copy Native Runtime DLLs](#setup---step-3-copy-native-runtime-dlls)
- [Setup - Step 4: Update the PowerShell Script](#setup---step-4-update-the-powershell-script)
- [Usage - Step 1: Run the PowerShell Script](#usage---step-1-run-the-powershell-script)
- [Usage - Step 2: Interactive Inference](#usage---step-2-interactive-inference)
- [Folder Structure](#folder-structure)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Contributing](#contributing)
- [Acknowledgments](#acknowledgments)

---

## Overview

This repository contains:

1. A .NET class library (LlamaLibrary) that uses LLamaSharp to perform inference tasks.  
2. A PowerShell script (run-inference.ps1) to interact with the library and run inference on a model.  
3. A runtimes folder containing native DLLs required for the library to function.

The library is designed to work with models like Phi-3.5-mini-instruct-Q4_K_L.gguf, and the PowerShell script provides an interactive interface for running inference.

---

## Prerequisites

Before using this repository, ensure you have the following installed:

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)  
- [PowerShell 7.0 or later](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3)  
- A compatible model file (e.g., Phi-3.5-mini-instruct-Q4_K_L.gguf -> https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF/resolve/main/Phi-3.5-mini-instruct-Q4_K_L.gguf?download=true )

---

## Setup - Step 1: Clone the Repository

Clone the repository to your local machine:

bash
git clone https://github.com/ssc-dsai/dev-finance-win-llama-llm.git
cd LlamaLibrary


## Setup - Step 2: Build the Project
Build the .NET project to generate the required DLLs:

dotnet build
This will create the DLLs in the bin/Debug/net8.0/ folder.

## Setup - Step 3: Copy Native Runtime DLLs
Navigate to the runtimes folder.
Copy the appropriate native DLLs (based on your system's CPU capabilities) to the output directory (bin/Debug/net8.0/).
For example, if your system supports AVX2, copy the DLLs from runtimes/avx2/ to bin/Debug/net8.0/.

## Setup - Step 4: Update the PowerShell Script
Open run-inference.ps1 in a text editor and update the following variables:

$llamaSharpPath = "C:\path\to\LlamaLibrary\bin\Debug\net8.0\LLamaSharp.dll"

$llamaLibraryPath = "C:\path\to\LlamaLibrary\bin\Debug\net8.0\LlamaLibrary.dll"

$modelPath = "C:\path\to\Phi-3.5-mini-instruct-Q4_K_L.gguf"  https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF/resolve/main/Phi-3.5-mini-instruct-Q4_K_L.gguf?download=true

Make sure the paths reflect the actual locations of the DLLs and model file on your system.

## Usage - Step 1: Run the PowerShell Script
Open a PowerShell 7.0+ terminal and run the script:

pwsh ./run-inference.ps1

## Usage - Step 2: Interactive Inference
Once the script runs, you will be prompted to enter text.

Type your prompt and press Enter to see the model's response.
Type exit to quit the script.
## Folder Structure

```
📦 LlamaLibrary
├─ LlamaLibrary.cs
├─ run-inference.ps1
├─ runtimes/
│  ├─ avx
│  ├─ avx2
│  ├─ avx512
│  └─ no_avx
├─ README.md
└─ bin
```

## Troubleshooting
1. Failed to Load DLLs
Ensure the native DLLs are in the same directory as LLamaSharp.dll and LlamaLibrary.dll.
Verify the paths in run-inference.ps1 are correct.
2. Failed to Create ModelParams
This error often occurs due to missing native dependencies.
Ensure the runtimes folder contains the correct DLLs for your system.
3. Failed to Load Model
Verify that the model file is valid and compatible with LLamaSharp.
Ensure the $modelPath variable in run-inference.ps1 points to the correct file.
4. Script Doesn't Run in PowerShell
Ensure you're using PowerShell 7.0 or later.
Run the script using:
pwsh ./run-inference.ps1

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## Acknowledgments
LLamaSharp for providing the core functionality.
Phi-3 for the model used in this example.
