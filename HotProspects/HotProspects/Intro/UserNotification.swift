//
//  UserNotification.swift
//  HotProspects
//
//  Created by Olibo moni on 24/05/2022.
//

import SwiftUI
import UserNotifications

struct UserNotification: View {
    @State private var authGranted = false
    
    //var notifClosure: () { } computed property
    var notifColosure = {    //closure
        let content = UNMutableNotificationContent()
        content.title = "Feed the Dogs"
        content.subtitle = "They look hungry"
        content.body = "a lot of jibberish"
        content.sound = .default
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
       
    }
    
    var body: some View {
        VStack {
            Button("Schedule Notification") {
                if !authGranted {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            
                            print("All set")
                            authGranted = true
                            notifColosure()
                            
                        } else if let error = error {
                            print("Error \(error.localizedDescription)")
                        }
                    }
                } else if authGranted {
                    notifColosure()
                }
                
               
            }
        }
    }
    
    func triggerNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Feed the Dogs"
        content.subtitle = "They look hungry"
        content.body = "a lot of jibberish"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct UserNotification_Previews: PreviewProvider {
    static var previews: some View {
        UserNotification()
    }
}


//Sample package
//extension Sequence {
//    public func random(_ num: Int) -> [Element] {
//        Array(shuffled().prefix(num))
//    }
//}
