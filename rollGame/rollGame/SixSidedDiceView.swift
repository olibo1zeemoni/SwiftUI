//
//  SixSidedDiceView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI

struct SixSidedDiceView: View {
    @State private var colors : [Color] = [.red, .blue,.green, .orange, .indigo, .purple, .gray, .pink, .yellow]
    @Binding  var sides: Int
    var body: some View {
        Image(systemName: "die.face.\(sides).fill")
            .resizable()
            .frame(width: 120, height: 120)
            .foregroundColor(
                colors.randomElement())
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct SixSidedDiceView_Previews: PreviewProvider {
    static var previews: some View {
        SixSidedDiceView(sides: .constant(4))
            .preferredColorScheme(.dark)
    }
}
