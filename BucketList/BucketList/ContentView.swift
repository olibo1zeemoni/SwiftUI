//
//  ContentView.swift
//  BucketList
//
//  Created by Olibo moni on 14/05/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coodinates){
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                    .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // create a new location
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                        
                    }
                }
            }
            .alert("Error Encountered", isPresented: $viewModel.showAlert) {
                Button("Cancel", role: .cancel) {
                    
                }
            } message: {
                Text(viewModel.alertMessage)
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            //unlock button
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
    
    init() {
        self._viewModel = StateObject(wrappedValue: ViewModel())
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







//    .onTapGesture {
//        let str = "Test Message"
//        let url = getDocumentsDirectory().appendingPathComponent("message.txt")
//        do{
//            try str.write(to: url, atomically: true, encoding: .utf8)
//            let input = try String(contentsOf: url)
//            print(input)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }

struct User: Identifiable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    
    let id = UUID()
    var firstName: String
    var lastName: String
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}


//enum LoadingState {
//    case loading, success, failed
//}
