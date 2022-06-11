//
//  MotionManager.swift
//  SpecialEffects
//
//  Created by Olibo moni on 08/04/2022.
//

import Foundation
import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    @Published var pitch: Double = 0.0
       @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0
       
       private var manager: CMMotionManager

       init() {
           self.manager = CMMotionManager()
           self.manager.deviceMotionUpdateInterval = 1/60
           self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
               guard error == nil else {
                   print(error!)
                   return
               }

               if let motionData = motionData {
                   self.pitch = motionData.attitude.pitch
                   self.roll = motionData.attitude.roll
                   self.yaw = motionData.attitude.yaw
               }
           }

       }
}
