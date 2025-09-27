//
//  CounterService.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 27/09/25.
//

import Foundation

protocol CounterService{
    
    func increment() async throws -> Int
    func reset() async -> Int
    func getCount() -> Int
}
