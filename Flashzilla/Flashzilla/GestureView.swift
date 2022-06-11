//
//  GestureView.swift
//  Flashzilla
//
//  Created by Olibo moni on 27/05/2022.
//

import SwiftUI

struct GestureView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
               let dragGesture = DragGesture()
                   .onChanged { value in offset = value.translation }
                   .onEnded { _ in
                       withAnimation {
                           offset = .zero
                           isDragging = false
                       }
                   }

               // a long press gesture that enables isDragging
               let pressGesture = LongPressGesture()
                   .onEnded { value in
                       withAnimation {
                           isDragging = true
                       }
                   }
        let combined = pressGesture.sequenced(before: dragGesture)

                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(offset)
                    .gesture(combined)
    }
}



struct GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView()
    }
}

//Magnification
//    .scaleEffect(finalAmount + currentAmount)
//    .gesture(
//        MagnificationGesture()
//            .onChanged{ amount in
//                currentAmount = amount - 1
//            }
//            .onEnded{ amount in
//                finalAmount += currentAmount
//                currentAmount = 0
//            }
//    )

//Rotation
//    .rotationEffect(finalAmount + currentAmount)
//    .gesture(
//        RotationGesture()
//            .onChanged{ angle in
//                currentAmount = angle
//            }
//            .onEnded{ angel in
//                finalAmount += currentAmount
//                currentAmount = .zero
//            }
//    )

//simultaneous gesture
//    .simultaneousGesture (
//        TapGesture()
//            .onEnded {
//                print("Vstack tapped")
//            }
//    )
