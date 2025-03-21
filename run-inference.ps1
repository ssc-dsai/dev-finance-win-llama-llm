# Define the paths to the DLLs
$llamaSharpPath = "C:\Users\BurneyA\source\repos\LlamaLibrary\bin\Debug\net8.0\LLamaSharp.dll"
$llamaLibraryPath = "C:\Users\BurneyA\source\repos\LlamaLibrary\bin\Debug\net8.0\LlamaLibrary.dll"

# Load the DLLs
try {
    Add-Type -Path $llamaSharpPath
    Add-Type -Path $llamaLibraryPath
    Write-Host "DLLs loaded successfully."
}
catch {
    Write-Host "Failed to load DLLs: $_"
    exit
}

# Define the model path
$modelPath = "C:\Users\BurneyA\Downloads\Phi-3.5-mini-instruct-Q4_K_L.gguf"

# Create ModelParams
try {
    $parameters = New-Object -TypeName LlamaLibrary.ModelParams -ArgumentList $modelPath
    $parameters.ContextSize = 4096  # Reduce the context size
    $parameters.BatchSize = 512     # Set a valid batch size
    $parameters.UBatchSize = 512    # Set a valid micro-batch size
    $parameters.Threads = 4         # Set the number of threads
    Write-Host "ModelParams created successfully."
}
catch {
    Write-Host "Failed to create ModelParams: $_"
    Write-Host "This error is often caused by missing native dependencies (e.g., llama.dll)."
    Write-Host "Ensure the native binaries are in the same directory as LLamaSharp.dll."
    exit
}

# Load the model using LLamaWeights
try {
    $model = [LLama.LLamaWeights]::LoadFromFile($parameters)
    Write-Host "Model loaded successfully."
}
catch {
    Write-Host "Failed to load model: $_"
    exit
}

# Create a context for inference
try {
    $context = New-Object -TypeName LLama.LLamaContext -ArgumentList $model, $parameters
    Write-Host "Context created successfully."
}
catch {
    Write-Host "Failed to create context: $_"
    Write-Host "This error is often caused by an incompatible or corrupted model file."
    Write-Host "Ensure the model file is valid and compatible with LLamaSharp."
    exit
}

# Create an executor for inference
try {
    $executor = New-Object -TypeName LLama.InstructExecutor -ArgumentList $context
    Write-Host "Executor created successfully."
}
catch {
    Write-Host "Failed to create executor: $_"
    exit
}

# Interactive loop
Write-Host "Model loaded. Type your prompts below. Type 'exit' to quit."
while ($true) {
    $prompt = Read-Host "You"

    # Exit condition
    if ($prompt.ToLower() -eq "exit") {
        Write-Host "Exiting..."
        break
    }

    # Run the prompt using the helper
    try {
        $inferenceParams = New-Object -TypeName LLama.Common.InferenceParams
        $inferenceParams.MaxTokens = 128  # You can adjust this
		$inferenceParams.SamplingPipeline = New-Object LLama.Sampling.DefaultSamplingPipeline
		# Manually set the temperature (if this approach works for your version)
		$inferenceParams.SamplingPipeline.Temperature = 0.7
        # Run inference using the helper
        $result = [LlamaLibrary.InferenceHelper]::RunInference($executor, $prompt, $inferenceParams)
        Write-Host "LLM: $result"
    }
    catch {
        Write-Host "Failed to run prompt: $_"
    }
}

# Cleanup
$context.Dispose()
$model.Dispose()
Write-Host "Model session completed and deallocated."
