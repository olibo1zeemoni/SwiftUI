//
//  DispatchView.swift
//  rollGame
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct DispatchView: View {
    @State private var counter = 0
    @State private var toggleStart = false
    var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State var date = Date.now
    @State private var hasTimeElapsed = false
    @State private var randomNumber = 0
    @State private var delayedNumber = 0
    
    var body: some View {
        VStack {
            Text("random number is \(randomNumber)")
                .padding()
                .font(.system(size: 30, weight: .medium, design: .serif))
            
            Text(hasTimeElapsed ? "Sorry, too late." : "Please enter above.")
                        .task( delayText)
                        .padding()
            
            Text(date.formatted(date: .omitted, time: .standard))
                .padding()
                .task {
                    await randomNumber = someLongTask()
                }
            
            Text("Counter \(counter)")
                .padding()
                .onReceive(timer) { time in
                    begin()
                    date = time
                }
            Button(toggleStart ? "Stop" : "Start"){
                toggleStart.toggle()
            }
            .padding()
            .foregroundColor(.red)
            
            Text("delayed number is \(delayedNumber)")
            
            Button("delay") {
                Task {
                    await delayedNumber = someLongTask()
                }
            }
            .padding()
        }
    }
    
    func begin(){
        
        guard toggleStart == true else { return }
       counter += 1
    }
    
    private func delayText() async {
          // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
          try? await Task.sleep(nanoseconds: 7_500_000_000)
          hasTimeElapsed = true
      }
    
    func someLongTask() async -> Int {
        try? await Task.sleep(seconds: 3) // 1 second
        return Int.random(in: 1 ... 6)
    }
}

struct DispatchView_Previews: PreviewProvider {
    static var previews: some View {
        DispatchView()
    }
}


extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
