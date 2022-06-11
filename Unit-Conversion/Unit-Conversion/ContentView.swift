//
//  ContentView.swift
//  Unit-Conversion
//
//  Created by Olibo moni on 18/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var length1: Double = 0.0
    @State private var unit1 = "Meters"
    @State private var unit2 = "Feet"
    @FocusState private var unitIsFocused: Bool
     
    
    private var units = ["Meters","Kilometers", "Feet"]
    
    var length2: Double {
        switch (unit1, unit2) {
        case ("Meters", "Kilometers"):
            return length1 / 1000
        case ("Kilometers", "Meters"):
            return length1 * 1000
        case ("Meters", "Feet"):
            return length1 * 3.28084
        case ("Feet", "Meters"):
            return length1 * 0.3048
        case (_, _):
            return length1
        }
        
        
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("From", selection: $unit1) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("First Unit")
                }
                Section {
                    TextField("Enter value", value: $length1, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($unitIsFocused)
                }
                
                Section {
                    Picker("To", selection: $unit2) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Second Unit")
                }
                Section {
                    Text(length2.formatted())
                }
            }
            .navigationTitle("Length Convertor")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        unitIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
