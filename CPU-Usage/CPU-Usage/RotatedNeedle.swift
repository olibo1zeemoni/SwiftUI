//
//  RotatedNeedle.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import Foundation
import SwiftUI

struct RotateNeedle: GeometryEffect {
    @Binding var cardinalDirection: String
    
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.cardinalDirection = self.angleToString(self.angle)
        }
        
        let rotation = CGAffineTransform(rotationAngle: CGFloat(angle * (Double.pi / 180.0)))
        let offset1 = CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0)
        let offset2 = CGAffineTransform(translationX: -size.width/2.0, y: -size.height/2.0)
        return ProjectionTransform(offset2.concatenating(rotation).concatenating(offset1))
    }
    
    func angleToString(_ a: Double) -> String {
        switch a {
        case 315..<405:
            fallthrough
        case 0..<45:
            return "North"
        case 45..<135:
            return "East"
        case 135..<225:
            return "South"
        default:
            return "West"
        }
    }
}
