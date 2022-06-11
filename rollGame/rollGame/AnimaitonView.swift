//
//  AnimaitonView.swift
//  rollGame
//
//  Created by Olibo moni on 04/06/2022.
//

import SwiftUI

struct AnimaitonView: View {
    @State private var sides = 40
    @State private var enabled = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            CardView(sides: sides)
                .padding()
                .offset(enabled ? offset : .zero)
                .animation(Animation.linear.repeatCount(50).speed(100), value: enabled)
                
                
            
            Button("start") {
                enabled.toggle()
                offset = CGSize(width: 5, height: 5)
                    
            }
            
        }
    }
    
}

struct AnimaitonView_Previews: PreviewProvider {
    static var previews: some View {
        AnimaitonView()
    }
}
