//
//  WelcomeView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSneaker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.").multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
