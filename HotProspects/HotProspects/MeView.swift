//
//  MeView.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymomous"
    @State private var email = "you@yoursite.com"
    @State private var phone = "0555552783"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
                TextField("Phone", text: $phone)
                    .textContentType(.telephoneNumber)
                Section {
                    Image(uiImage: qrCode)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .contextMenu {
                            Button {
                                //save data
                                let imageSaver = ImageSaver()
                                imageSaver.writeToPhotoAlbum(image: qrCode)
                                
                            } label: {
                                Label("Save to Photos", systemImage: "square.and.arrow.down")
                            }
                        }
                }
                
            }
            .navigationTitle("Your Code")
            .onAppear {
                updateCode()
            }
            .onChange(of: name) { _ in updateCode() }
            .onChange(of: email) { _ in updateCode() }
            .onChange(of: phone) { _ in updateCode() }
            
        }
    }
    
    func updateCode(){
      qrCode = generateQRcode(string: "\(name)\n\(email)\n\(phone)")
    }
    
    func generateQRcode(string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle")  ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
