//
//  Challenge.swift
//  LayoutAndGeometry
//
//  Created by Olibo moni on 31/05/2022.
//

import SwiftUI

struct Challenge: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow, .indigo]
    
    var body: some View {
        ZStack {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: 20 + ( 20 * (Double(index) / 50)))
                    
                                .background(Color(hue: Double(index) * 0.020409, saturation: 1, brightness: 1)) //colors[index % 8]
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                
                        }
                        .frame(height: 40)
                    }
                }
                
            }
        }
        .background(.clear)
        .mask(LinearGradient(gradient: Gradient(colors: [.white, .white, .white, .clear]), startPoint: .bottom, endPoint: .top))
            
    }
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
           // .preferredColorScheme(.dark)
    }
}
