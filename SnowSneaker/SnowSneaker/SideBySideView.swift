//
//  SideBySideView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct SideBySideView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("Hello World")
            } label: {
                Text("Primary")
            }.navigationTitle("Primary")
            
            Text("Seconday")
            Text("Tertiary")
        }
    }
}

struct SideBySideView_Previews: PreviewProvider {
    static var previews: some View {
        SideBySideView()
    }
}
