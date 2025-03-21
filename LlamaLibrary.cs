using System.Text;
using System;
using System.Collections.Generic;
using LLama; // Main namespace for LLamaSharp
using LLama.Abstractions;
using LLama.Common;
using LLama.Native; // For common types like InferenceParams

namespace LlamaLibrary
{
    public class ModelParams : IContextParams, IModelParams
    {
        // IModelParams implementation
        public string ModelPath { get; set; }
        public bool CheckTensors { get; set; }
        public int GpuLayerCount { get; set; }
        public int MainGpu { get; set; }
        public List<MetadataOverride> MetadataOverrides { get; set; } = new List<MetadataOverride>();
        public GPUSplitMode? SplitMode { get; set; }
        public TensorSplitsCollection TensorSplits { get; set; } = new TensorSplitsCollection();
        public bool UseMemoryLock { get; set; }
        public bool UseMemorymap { get; set; }
        public bool VocabOnly { get; set; }

        // IContextParams implementation
        public LLamaAttentionType AttentionType { get; set; }
        public uint BatchSize { get; set; }
        public int? BatchThreads { get; set; }
        public uint? ContextSize { get; set; }
        public float? DefragThreshold { get; set; }
        public bool Embeddings { get; set; }
        public Encoding Encoding { get; set; } = Encoding.UTF8;
        public bool FlashAttention { get; set; }
        public bool NoKqvOffload { get; set; }
        public LLamaPoolingType PoolingType { get; set; }
        public float? RopeFrequencyBase { get; set; }
        public float? RopeFrequencyScale { get; set; }
        public uint SeqMax { get; set; }
        public int? Threads { get; set; }
        public GGMLType? TypeK { get; set; }
        public GGMLType? TypeV { get; set; }
        public uint UBatchSize { get; set; }
        public float? YarnAttentionFactor { get; set; }
        public float? YarnBetaFast { get; set; }
        public float? YarnBetaSlow { get; set; }
        public float? YarnExtrapolationFactor { get; set; }
        public uint? YarnOriginalContext { get; set; }
        public RopeScalingType? YarnScalingType { get; set; }

        // Primary constructor
        public ModelParams(string modelPath)
        {
            ModelPath = modelPath ?? throw new ArgumentNullException(nameof(modelPath));
        }
    }

    public static class InferenceHelper
    {
        public static string RunInference(InstructExecutor executor, string prompt, InferenceParams inferenceParams)
        {
            var sb = new StringBuilder();
            var task = Task.Run(async () =>
            {
                await foreach (var token in executor.InferAsync(prompt, inferenceParams))
                {
                    sb.Append(token);
                }
            });
            task.Wait();
            return sb.ToString();
        }
    }
}