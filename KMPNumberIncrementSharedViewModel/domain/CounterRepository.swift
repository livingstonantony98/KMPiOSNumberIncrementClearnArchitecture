//
//  CounterRepository.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 27/09/25.
//

// Domain/CounterRepository.swift
protocol CounterRepository {
    func increment() async throws -> Int
    func reset() async -> Int
    func getCount() -> Int
}
