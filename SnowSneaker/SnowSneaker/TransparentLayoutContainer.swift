//
//  TransparentLayoutContainer.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: George")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct TransparentLayoutContainer: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    //toggle layout using sizeclass
    var body: some View {
        if sizeClass == .compact {
            VStack {
                UserView()
            }
        } else {
            HStack{
                UserView()
            }
        }
           
    }
}


struct TransparentLayoutContainer_Previews: PreviewProvider {
    static var previews: some View {
        TransparentLayoutContainer()
    }
}
