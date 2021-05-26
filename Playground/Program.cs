using System;
using System.Threading;
using System.Threading.Tasks;

using CancellationTokenSource cancellationTokenSource = new();

Console.CancelKeyPress += (_, e) => {
    cancellationTokenSource.Cancel();
    e.Cancel = true;
};

try
{
    Console.WriteLine("Press Ctl-C to terminate.");
    await VeryLongTask(cancellationTokenSource.Token);
}
catch (OperationCanceledException)
{
    Console.WriteLine();
    Console.WriteLine("Boo! Operation cancelled!");
}

async Task VeryLongTask(CancellationToken cancellationToken)
{
    Console.WriteLine("Starting a very long operation.");

    while (true)
    {
        cancellationToken.ThrowIfCancellationRequested();
        Console.Write(".");
        await Task.Delay(TimeSpan.FromSeconds(1));
    }
}
