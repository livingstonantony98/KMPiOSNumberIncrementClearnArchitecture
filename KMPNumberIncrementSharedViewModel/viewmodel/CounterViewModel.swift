//
//  CounterViewModel.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 26/09/25.
//

import Combine
import Foundation

class CounterViewModel: ObservableObject {
    
    @Published private(set) var state: CounterState = .initial
    
    
    func processIntent(_ intent: CounterIntent){
        switch intent {
        case .increaseCount:
            handleIncreaseCount()
        case .reset:
            handleReset()
        }
    }
    
    private func handleIncreaseCount(){
        
        guard state.status != .loading, state.tapCount < state.maxAttempts else { return }
        
        state = CounterState(
            tapCount: state.tapCount,
            maxAttempts: state.maxAttempts,
            status: .loading,
            progress: 0.0
        )
        
        Task{
            
            try? await Task.sleep(for: .seconds(1))
            
            await MainActor.run {
                let newCount  = state.tapCount + 1
                var newStatus: CounterState.Status = .ready
                
                if newCount >= state.maxAttempts {
                    newStatus = .error
                }
                
                state = CounterState(
                                    tapCount: newCount,
                                    maxAttempts: state.maxAttempts,
                                    status: newStatus,
                                    progress: 0.0
                                )
            }
        }
    }
    
    private func handleReset(){
        state = .initial
    }
}
