//
//  ConfirmationView.swift
//  InstaFilter
//
//  Created by Olibo moni on 13/05/2022.
//

import SwiftUI

struct ConfirmationView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .onTapGesture {
                    showingConfirmation = true
                }
                .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                    Button("Red"){ backgroundColor = .red}
                    Button("Blue"){ backgroundColor = .blue}
                    Button("Green"){ backgroundColor = .green}
                    Button("Cancel", role: .cancel){ }
                }message: {
                    Text("Select a new color")
                }
            
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
