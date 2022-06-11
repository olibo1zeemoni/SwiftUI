//
//  ResortView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct ResortView: View {
    @EnvironmentObject var favorites: Favorites
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    
    let resort: Resort
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                    .scaledToFit()
                    .overlay(
                        HStack(spacing: 0) {
                            Image(systemName: "c.circle")
                            Text("\(resort.imageCredit)")
                                .font(.system(size: 15, weight: .light, design: .default))
                                .foregroundColor(.secondary)
                            
                        }
                            .padding()
                        , alignment: .bottomTrailing)
                    
                }
                HStack {
                    if sizeClass == .compact && typeSize > .large  {
                        VStack(spacing: 10){  ResortDetailView(resort: resort) }
                        VStack(spacing: 10){ SkiDetailView(resort: resort) }
                    } else {
                        ResortDetailView(resort: resort)
                        SkiDetailView(resort: resort)
                    }
                   
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if favorites.contains(resort) {
                    favorites.remove(resort)
                } else {
                    favorites.add(resort)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More Info" , isPresented: $showingFacility, presenting: selectedFacility) { _ in
            
        }message: { facility in
            Text(facility.descripition)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
                .environmentObject(Favorites())
        }
    }
}
