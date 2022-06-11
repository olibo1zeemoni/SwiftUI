//
//  ContextMenu.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import SwiftUI

struct ContextMenu: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu{
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    Button("green") {
                        backgroundColor = .green
                    }
                    Button("blue") {
                        backgroundColor = .blue
                    }
                }
            
        }
    }
    
}

struct ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenu()
    }
}
