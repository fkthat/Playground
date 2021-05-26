using System;
using System.Threading;
using System.Threading.Tasks;

using CancellationTokenSource cancellationTokenSource = new();

Console.CancelKeyPress += (_, e) => {
    cancellationTokenSource.Cancel();
    e.Cancel = true;
};

await RunInfiniteLoop(cancellationTokenSource.Token);

Task RunInfiniteLoop(CancellationToken cancellationToken) =>
    Task.Run(() => Console.ReadKey(true), cancellationToken);
