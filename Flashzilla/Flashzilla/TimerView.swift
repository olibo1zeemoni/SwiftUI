//
//  TimerView.swift
//  Flashzilla
//
//  Created by Olibo moni on 27/05/2022.
//

import SwiftUI

struct TimerView: View {
    @State private var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //tolerance for energy comsumption optimization
    
    var body: some View {
        Text("hello world")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is \(time)")
                }
                counter += 1
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
