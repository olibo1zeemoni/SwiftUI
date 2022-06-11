//
//  CHHapticsView.swift
//  Flashzilla
//
//  Created by Olibo moni on 27/05/2022.
//
import CoreHaptics
import SwiftUI

struct CHHapticsView: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello")
            .onAppear{
                prepareHaptics()
            }
            .onTapGesture {
                complexSuccess()
            }
    }
    func simpleSuccess(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error ocured \(error.localizedDescription)")
        }
    }
    
    func complexSuccess(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 2, by: 0.1) {
            let internsity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [internsity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 2, by: 0.1) {
            let internsity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [internsity, sharpness], relativeTime: i + 2)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
    
}


struct CHHapticsView_Previews: PreviewProvider {
    static var previews: some View {
        CHHapticsView()
    }
}
