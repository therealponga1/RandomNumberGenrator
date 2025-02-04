﻿namespace Quantum.RandomNumberGenrator {
    
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation SampleQuantumRandomNumberGenerator() : Result {
        use q = Qubit(); // Allocate a qubit.
        H(q);           // Put the qubit to superposition. It now has a 50% chance of being 0 or 1
        return MResetZ(q); // Measure the qubit value
    }
     operation SampleRandomNumberinRange(max : Int) : Int{
        mutable bits = new Result[0];
        for idxBit in 1..BitSizeI(max){
            set bits += [SampleQuantumRandomNumberGenerator()];
        }
        let sample = ResultArrayAsInt(bits);
        return sample > max ? SampleRandomNumberinRange(max) | sample;
    }
    @EntryPoint()
    operation SampleRandomNumber() : Int{
        let max = 1000;
        Message($"Random number between 0 and {max}: ");
        return SampleRandomNumberinRange(max);
    }
   
}
