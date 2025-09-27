//
//  CounterViewModel.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 26/09/25.
//

import Combine
import Foundation
import Foundation

@MainActor
class CounterViewModel: ObservableObject {
    @Published private(set) var state: CounterState = .initial
    
    private let repository: CounterRepository
    
    init(repository: CounterRepository) {
        self.repository = repository
    }
    
    func send(intent: CounterIntent) {
        switch intent {
        case .increaseCount:
            increment()
        case .reset:
            reset()
        }
    }
    
    private func increment() {
        Task {
            updateState { $0.copy(status: .loading) }
            
            do {
                let newValue = try await repository.increment()
                if newValue >= state.maxAttempts {
                    updateState { _ in
                        CounterState(
                            tapCount: newValue,
                            maxAttempts: state.maxAttempts,
                            status: .error // reached limit
                        )
                    }
                } else {
                    updateState { _ in
                        CounterState(
                            tapCount: newValue,
                            maxAttempts: state.maxAttempts,
                            status: .ready
                        )
                    }
                }
            } catch {
                updateState { _ in
                    CounterState(
                        tapCount: state.tapCount,
                        maxAttempts: state.maxAttempts,
                        status: .error
                    )
                }
            }
        }
    }
    
    private func reset() {
        Task {
            let newValue = await repository.reset()
            updateState { _ in
                CounterState(
                    tapCount: newValue,
                    maxAttempts: state.maxAttempts,
                    status: .ready
                )
            }
        }
    }
    
    private func updateState(_ reducer: (CounterState) -> CounterState) {
        state = reducer(state)
    }
}

