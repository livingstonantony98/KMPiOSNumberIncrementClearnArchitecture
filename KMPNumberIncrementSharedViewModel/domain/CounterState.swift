//
//  CounterState.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 26/09/25.
//

struct CounterState {
    let tapCount: Int
    let maxAttempts: Int
    let status: Status
    
    enum Status {
        case ready
        case loading
        case error
    }
    
    static let initial = CounterState(
        tapCount: 0,
        maxAttempts: 10,
        status: .ready,
    )
}


extension CounterState {
    func copy(
        tapCount: Int? = nil,
        maxAttempts: Int? = nil,
        status: Status? = nil
    ) -> CounterState {
        CounterState(
            tapCount: tapCount ?? self.tapCount,
            maxAttempts: maxAttempts ?? self.maxAttempts,
            status: status ?? self.status
        )
    }
}
