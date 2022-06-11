//
//  CardView.swift
//  rollGame
//
//  Created by Olibo moni on 02/06/2022.
//

import SwiftUI

struct CardView: View {
    
    let sides: Int
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        Rectangle()
            .fill(Color.random)
            .frame(width: 120, height: 120, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                Text(String(sides))
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
            }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(sides: (20))
    }
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
