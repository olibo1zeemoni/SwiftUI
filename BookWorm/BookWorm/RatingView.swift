//
//  RatingView.swift
//  BookWorm
//
//  Created by Olibo moni on 25/04/2022.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(number: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
                
            }
            .accessibilityElement()
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel("Rating")
            .accessibilityValue(rating == 1 ? "1 star" : "\(rating) star")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    if rating < maximumRating { rating += 1 }
                case .decrement:
                    if rating > 1 {rating -= 1 }
                default:
                    break
                }
            }
        }
        
    }
    
    func image(number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}


//                    .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
//                    .accessibilityRemoveTraits(.isImage)
//                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
