//
//  SwipeAction.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import SwiftUI

struct SwipeAction: View {
    var body: some View {
        List{
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        print("pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("share")
                    } label: {
                        Label("share", systemImage: "square.and.arrow.up.fill")
                    }
                    .tint(.green)
                }
        }
    }
}

struct SwipeAction_Previews: PreviewProvider {
    static var previews: some View {
        SwipeAction()
    }
}
