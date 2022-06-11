//
//  ContentView.swift
//  SpecialEffects
//
//  Created by Olibo moni on 08/04/2022.
//

import SwiftUI
import CoreMotion

struct ParallaxMotionModifier: ViewModifier {
    
    @ObservedObject var manager: MotionManager
    var magnitude: Double
    
    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat(manager.roll * magnitude), y: CGFloat(manager.pitch * magnitude))
    }
}

struct ContentView: View {
    @State private var amount = 0.0
   // let manager = CMMotionManager()
    @ObservedObject var manager = MotionManager()
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Color(hue: manager.pitch , saturation: 1, brightness: 1)
                    .frame(width: 300, height: 300)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 30))
                    .blendMode(.screen)
               // Spacer()
                Color(hue: manager.roll , saturation: 1, brightness: 1)
                    .frame(width: 200, height: 200)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 30))
                    .blendMode(.screen)
                
               
            }
               Text("Device yaw: \(manager.yaw)")
               Text("Device pitch: \(manager.pitch)")
               Text("Device roll: \(manager.roll)")
                                   .foregroundColor(.blue)
                           
            
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
//
//            Slider(value: $amount)
//                .padding()
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        //.background(.black)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// control blur and saturation
//Image("Van")
//    .resizable()
//    .scaledToFit()
//    .frame(width: 300)
//    .saturation(amount)
//    .blur(radius: (1 - amount) * 20)
