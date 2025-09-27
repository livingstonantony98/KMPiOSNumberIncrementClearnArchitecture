//
//  DummyCounterService.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 27/09/25.
//

import Foundation

class DummyCounterService: CounterService{
    
    private var counter: Int = 0
    private let maxCount: Int = 10
    
    func increment() async throws -> Int {
        
        try await Task.sleep(for: .seconds(0.5))
        
        if counter >= maxCount {
            throw NSError(domain: "CounterService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Maximum count reached"])
        }
        
        counter += 1
        return counter
    }
    
    func reset() async -> Int {
        counter = 0
        return counter
    }
    
    func getCount() -> Int {
        return counter
    }
    
}
