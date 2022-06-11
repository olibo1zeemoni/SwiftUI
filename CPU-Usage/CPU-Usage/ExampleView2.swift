//
//  ExampleView2.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct ExampleView2: View {
    @State private var flag = false
        @State private var cardinalDirection = ""
        
        var body: some View {
            return VStack(spacing: 30) {
                CPUWheel().frame(height: 150)
                
                Text("\(cardinalDirection)").font(.largeTitle)
                Image(systemName: "location.north")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .modifier(RotateNeedle(cardinalDirection: self.$cardinalDirection, angle: self.flag ? 0 : 360))
                
                
                Button("Animate") {
                    withAnimation(.easeInOut(duration: 3.0)) {
                        self.flag.toggle()
                    }
                }
            }
        }
    }

struct ExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView2()
    }
}
