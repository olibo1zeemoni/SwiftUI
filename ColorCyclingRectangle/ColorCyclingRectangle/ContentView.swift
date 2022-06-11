//
//  ContentView.swift
//  ColorCyclingRectangle
//
//  Created by Olibo moni on 09/04/2022.
//

import SwiftUI

struct ColorCyclingRectangle : View {
    var amount = 0.0
    var steps = 100
    
    var body: some View{
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                                    startPoint: .top,
                                    endPoint: .bottom)
                                  ,lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

struct ContentView: View {
    @State private var amount = 0.0
    @State private var steps = 100
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: amount, steps: steps)
                .frame(width: 300, height: 300)
            Slider(value: $amount)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
