//
//  ContentView.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ExampleView1(), label: { Text("Example #1 - OutOfControlView") })
                NavigationLink(destination: ExampleView2(), label: { Text("Example #2 - Cardinal Direction") })
                NavigationLink(destination: ExampleView3(), label: { Text("Example #3 - Observable Object") })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
