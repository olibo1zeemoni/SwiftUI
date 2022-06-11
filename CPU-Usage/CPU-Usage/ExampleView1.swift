//
//  ExampleView1.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct ExampleView1: View {
    @State private var showOutOfControlView = false
    
    var body: some View {
        VStack(spacing: 10) {
            CPUWheel().frame(height: 150)

            VStack {
                if showOutOfControlView { OutOfControlView() }
            }.frame(height: 80)

            Button(self.showOutOfControlView ? "Hide": "Show") {
                self.showOutOfControlView.toggle()
            }
        }
    }
}

struct ExampleView1_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView1()
    }
}
