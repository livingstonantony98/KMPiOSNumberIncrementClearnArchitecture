//
//  KMPNumberIncrementSharedViewModelApp.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 24/09/25.
//

import SwiftUI

@main
struct KMPNumberIncrementSharedViewModelApp: App {
    var body: some Scene {
        WindowGroup {
            let service = DummyCounterService()
            let repo = CounterRepositoryImpl(service: service)
            let vm = CounterViewModel(repository: repo)
            ContentView(viewModel: vm)
        }
    }
}
