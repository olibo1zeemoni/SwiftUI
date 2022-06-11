//
//  ContentView.swift
//  Arrow
//
//  Created by Olibo moni on 09/04/2022.
//

import SwiftUI

struct Arrow: Shape {
    var thickness: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY ))
        path.addLine(to: CGPoint(x: rect.width / 4, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: rect.midX, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height / 2))
        
        
        return path
    }
}

struct ContentView: View {
    @State private var thickness = 3.0
    var body: some View {
        VStack {
            Spacer()
            Arrow(thickness: thickness)
                .stroke(.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round ))
                
            
            Text("Thickness")
            Slider(value: $thickness, in: 1...10)
                .padding([.horizontal, .bottom])
                
        }
        
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
