//
//  AuthenticateView.swift
//  BucketList
//
//  Created by Olibo moni on 16/05/2022.
//
import LocalAuthentication
import SwiftUI

struct AuthenticateView: View {
    @State private var unlocked = false
     
     var body: some View {
         VStack {
             if unlocked {
                 Text("Unlocked")
             } else{
                 Text("Locked")
             }
         }.onAppear(perform: authenticate)
     }
     
     func authenticate() {
         let context = LAContext()
         var error: NSError?
         
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
             let reason = "We need to unlock your data"
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                 if success {
                     // authenticated successfully
                     unlocked = true
                 } else {
                     //we hit a problem
                 }
             }
         } else {
             //no biometrics
         }
     }
    func getDocumentsDirectory()-> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
