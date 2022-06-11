//
//  OptionalAlert.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct User: Identifiable {
    let id: String = "Taylor Swift"
}

struct OptionalAlert: View {
    @State private var user: User?
    @State private var ispresented = false
    @State private var isShowingSecondAlert = false
    
    var body: some View {
        Text("hello world")
            .onTapGesture {
                user = User()
                ispresented.toggle()
            }
            .alert("Next Screen", isPresented: $ispresented, presenting: user) { _ in }
            .alert("Another Alert", isPresented: $isShowingSecondAlert, actions: {
                Button("Ok", role: .cancel) {
                    print("second alert tapped")
                }
            }) {
                Text("a nice message")
            }
    }
}

struct OptionalAlert_Previews: PreviewProvider {
    static var previews: some View {
        OptionalAlert()
    }
}
