//
//  ContentView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

extension View {
    @ViewBuilder  func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    
    @StateObject var favorites = Favorites()
   @State private var sortOrder : SortOrder = .normal
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    var filteredList: [Resort] {
        if searchText.isEmpty {
            return sortList()
        } else {
            return sortList().filter{ $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredList) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1))
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                        
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                            
                        Image(systemName: "heart.fill")
                            
                        .accessibilityLabel("This is a favorite resort")
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Label("", systemImage: "arrow.up.arrow.down")
                            .padding()
                    }
                    .contextMenu {
                        Button("Default"){sortOrder = .normal }
                        Button("A-Z"){ sortOrder = .alphabetical}
                        Button("Country"){ sortOrder = .country}
                        
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            
            
            WelcomeView()
            
        }
        .navigationViewStyle(.automatic)
        .environmentObject(favorites)
        //.phoneOnlyNavigationView()
    }
    
    enum SortOrder {
        case normal, alphabetical, country
    }
    
    func sortList()-> [Resort] {
        switch sortOrder {
        case .normal:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: {$0.name < $1.name})
        case .country:
            return resorts.sorted(by: {$0.country < $1.country})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
