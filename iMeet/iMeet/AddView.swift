//
//  AddView.swift
//  iMeet
//
//  Created by Olibo moni on 21/05/2022.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false
    @Binding  var firstName: String
    @Binding  var lastname: String
    @Binding  var inputImage: UIImage?
    @Binding var longitude: Double
    @Binding var latitude: Double
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var source = "Photos"
    private let sources = ["Camera","Photos"]
    
    let locationFetcher = LocationFetcher()
    
    var disableSave: Bool {
        guard !firstName.isEmpty && !lastname.isEmpty && inputImage != nil else { return true }
        return false
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select source", selection: $source) {
                    ForEach(sources, id:\.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                Spacer(minLength: 40)
                
                if source == "Photos" {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                            
                        Text("Tap to select photo")
                            
                        if inputImage != nil {
                            Image(uiImage: inputImage!)
                                                   .resizable()
                                                   .scaledToFit()
                        }
                       
                    }
                    .onTapGesture {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                            
                        Text("Tap to take photo")
                            
                        if inputImage != nil {
                            Image(uiImage: inputImage!)
                                                   .resizable()
                                                   .scaledToFit()
                        }
                       
                    }
                    .onTapGesture {
                        #if targetEnvironment(simulator)
                        sourceType = .photoLibrary
                        #else
                           sourceType = .camera 
                        #endif
                        showImagePicker = true
                    }
                }
                Form {
                    Section {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastname)
                    }header: {
                        Text("Add name")
                    }
                    
                }
                
            }
            .onAppear(perform: {
                startTracking()
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage, sourceType: $sourceType)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                       captureLocation()
                        dismiss()
                    }
                    .disabled(disableSave)
                }
            }
            .navigationTitle("Add Person")
        .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func captureLocation(){
        if let location = locationFetcher.lastKnownLocation {
            longitude = location.longitude
            latitude = location.latitude
        }
    }
    
    func startTracking() {
        self.locationFetcher.start()
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(firstName: .constant("firstname"), lastname: .constant("lastName"), inputImage: .constant(UIImage(named: "Van")), longitude: .constant(0.0000), latitude: .constant(0.0000))
    }
}
