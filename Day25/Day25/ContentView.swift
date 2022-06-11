//
//  ContentView.swift
//  Day25
//
//  Created by Olibo moni on 22/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var agreedToTerms = false
    @State private var agreedToPolicy = false
    @State private var agreedToEmail = false
    
    var body: some View {
//        let binding = Binding(
//            get: { selection},
//            set: { selection = $0})
//        return VStack {
//            Picker("Select a number", selection: binding) {
//                ForEach(0..<3){
//                    Text("Item \($0)")
//                }
//            }
//            .pickerStyle(.segmented)
//        }
        
        let agreedToAll = Binding<Bool> (
            get: { agreedToTerms && agreedToPolicy && agreedToEmail},
            set: {agreedToTerms = $0
                agreedToPolicy = $0
                agreedToEmail = $0
            }
        )
        return VStack {
            Toggle("Agreed To Terms", isOn: $agreedToTerms)
            Toggle("Agreed To Email", isOn: $agreedToEmail)
            Toggle("Agreed To Policy", isOn: $agreedToPolicy)
            Toggle("Agreed To All ", isOn: agreedToAll)
            
        }
        .padding()
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
