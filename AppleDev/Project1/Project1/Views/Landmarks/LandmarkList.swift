//
//  landmarkList.swift
//  Project1
//
//  Created by Olibo moni on 03/04/2022.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter {landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle("Favorites", isOn: $showFavoritesOnly)
                ForEach(filteredLandmarks) { landmark in
                    
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                   
                } label: {
                    LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct landmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE (2nd generation)", "iPhone 13 mini", "iPad Pro (12.9-inch) (5th generation)"], id: \.self) {device in
//            LandmarkList()
//                .previewDevice(PreviewDevice(rawValue: device))
//                .previewDisplayName(device)
//        }
        LandmarkList()
            .environmentObject(ModelData())
    }
}
