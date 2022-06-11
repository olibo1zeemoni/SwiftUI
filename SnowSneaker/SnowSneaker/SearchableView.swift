//
//  SearchableView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
       let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
   
    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, placement: .toolbar, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter{ $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}
