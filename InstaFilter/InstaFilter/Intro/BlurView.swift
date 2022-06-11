//
//  BlurView.swift
//  InstaFilter
//
//  Created by Olibo moni on 13/05/2022.
//
import SwiftUI

struct BlurView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { newValue in
                    print("new value is \(newValue)")
                }
            
            Button("Randon Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
