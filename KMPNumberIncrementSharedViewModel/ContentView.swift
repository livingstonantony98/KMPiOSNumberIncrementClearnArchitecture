//
//  ContentView.swift
//  KMPNumberIncrementSharedViewModel
//
//  Created by Philosopher on 24/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = 0
    @State private var maxAttempts = 10
    @State private var showError = false
    @State private var isLoading = false
    @State private var progress = 0.0
    
    var body: some View {
        
        VStack{
            
            HStack {
                Spacer() // Pushes the content to the right
                
                Text("ATTEMPTS:")
                    .foregroundColor(.green)
                    .padding(.top, 20) // Adds some padding from the top edge
                
                // Text at the top right
                Text("\(tapCount)/\(maxAttempts)")
                    .padding(.top, 20) // Adds some padding from the top edge
                    .padding(.trailing, 20) // Adds some padding from the right edge
            }
            
            Spacer()
            
            if isLoading {
                VStack {
                    Text("Loading...")
                    ProgressView()
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(width: 200)
                }
            }else{
                Text("Count: \(tapCount)")
                    .bold()
                    .font(.largeTitle)
                    .opacity(showError ? 0.3 : 1.0)
                
            }
            
            
            
            if showError  {
                VStack(spacing: 20) {
                    Text("Maximum attempts reached!")
                        .bold()
                        .foregroundColor(.red)
                    
                    Button("Reset") {
                        tapCount = 0
                        showError = false
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            }
            Spacer()
            
            Button(action: {
                if tapCount < maxAttempts {
                    
                    isLoading = true
                    Task{
                        try await Task.sleep(for: .seconds(1))
                        tapCount += 1
                        isLoading = false
                        
                        if tapCount == maxAttempts {
                            showError = true
                        }
                    }
                    
                }
            }) {
                Text("TAP TO INCREASE")
                    .padding()
                    .background((tapCount < maxAttempts && !isLoading) ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(tapCount >= maxAttempts || isLoading)
            .padding(.bottom, 20)
        }
        
        Spacer() // Pushes the content to the center vertically
    }
    
}




#Preview {
    ContentView()
}
