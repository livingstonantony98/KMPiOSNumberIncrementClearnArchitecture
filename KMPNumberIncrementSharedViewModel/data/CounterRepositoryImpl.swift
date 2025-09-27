//
//  CounterRepositoryImpl.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 27/09/25.
//
import Foundation

class CounterRepositoryImpl: CounterRepository{
    
    private let service: CounterService
    
    init(service: CounterService) {
        self.service = service
    }
    
    func increment() async throws -> Int {
        try await service.increment()
    }
    
    func reset() async -> Int {
        await service.reset()
    }
    
    func getCount() -> Int {
        service.getCount()
    }
}
