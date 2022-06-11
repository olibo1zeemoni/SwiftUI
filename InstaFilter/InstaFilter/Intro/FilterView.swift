//
//  FilterView.swift
//  InstaFilter
//
//  Created by Olibo moni on 13/05/2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterView: View {
    @State private var image: Image?
     
     var body: some View {
         VStack {
             image?
                 .resizable()
                 .scaledToFit()
         }
         .onAppear {
             loadImage()
         }
     }
     func loadImage(){
         guard let inputImage = UIImage(named: "Example") else { return }
         let beginImage = CIImage(image: inputImage)
         
         let context = CIContext()
         let currentFilter = CIFilter.pixellate()  //sepiaTone()
         currentFilter.inputImage = beginImage
 //        currentFilter.radius = 1000
 //        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
         let amount = 1.0
         let inputKeys = currentFilter.inputKeys
         
         if inputKeys.contains(kCIInputIntensityKey) {
             currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
         }
         
         if inputKeys.contains(kCIInputScaleKey) {
             currentFilter.setValue(amount * 100, forKey: kCIInputScaleKey)
         }
         
         if inputKeys.contains(kCIInputRadiusKey) {
             currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
         }
         
         guard let outputImage = currentFilter.outputImage else { return }
         
         if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
             let uiImage = UIImage(cgImage: cgImg)
             image = Image(uiImage: uiImage)
         }
         
     }
 }


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
