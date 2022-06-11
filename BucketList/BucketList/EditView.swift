//
//  EditView.swift
//  BucketList
//
//  Created by Olibo moni on 17/05/2022.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Emplacement
    
    @State private var name: String
    @State private var  description: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var onSave: (Emplacement) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("name", text: $name)
                    TextField("description", text: $description)
                }
                
                Section {
                    switch loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(pages, id: \.pageid) {page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                            
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save"){
                    let newLocation = Emplacement(id: UUID(), name: name, description: description, latitude: location.latitude, longitude: location.longitude)
//                    newLocation.id = UUID()
//                    newLocation.name = name
//                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    init(location: Emplacement, onSave: @escaping (Emplacement) -> Void){
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coodinates.latitude)%7C\(location.coodinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        let url = URL(string: urlString)!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // we got some data back!
            let items = try JSONDecoder().decode(Results.self, from: data)
            
            // success – convert the array values to our pages array
            pages = items.query.pages.values.sorted() // { $0.title < $1.title }
            loadingState = .loaded
        } catch {
            // if we're still here it means the request failed somehow
            loadingState = .failed
        }
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Emplacement.example){ _ in
            
        }
    }
}
