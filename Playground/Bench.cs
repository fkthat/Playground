using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;
using FakeItEasy;
using FluentAssertions;
using Xunit;
using Xunit.Abstractions;

namespace Playground
{
    public class Bench
    {
        private readonly ITestOutputHelper _testOutput;

        public Bench(ITestOutputHelper testOutput)
        {
            _testOutput = testOutput;
        }

        [Fact]
        public void Bench_Hashset()
        {
        }

        private static IEnumerable<int> GetRandomIntSequence() =>
            Enumerable.Repeat(0, 1000 ^ 2)
                .Select(_ => RandomNumberGenerator.GetInt32(int.MaxValue));
    }
}
