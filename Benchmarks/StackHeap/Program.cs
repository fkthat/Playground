using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

BenchmarkRunner.Run<StackHeap>();

public class StackHeap
{
    [Benchmark]
    public void ReadWriteStack()
    {
        StackData data = new();
        data.Value = 0;
        // Это добавлено для симметрии бенчмарков
        HeapData _ = new();

        for (var i = 0; i < int.MaxValue; i++)
        {
            var value = data.Value;
            data.Value = value + 1;
        }
    }

    [Benchmark]
    public void ReadWriteHeap()
    {
        // Это добавлено для симметрии бенчмарков
        StackData _ = new();
        _.Value = 0;
        HeapData data = new();

        for (var i = 0; i < int.MaxValue; i++)
        {
            var value = data.Value;
            data.Value = value + 1;
        }
    }
}

internal struct StackData
{
    public int Value;
}

internal class HeapData
{
    public int Value;
}

