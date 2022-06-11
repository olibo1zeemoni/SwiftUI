//
//  ContentView.swift
//  WeSplit
//
//  Created by Olibo moni on 16/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
        
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var total: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                        //ForEach(0..<101) {
                            Text($0 , format: .percent)
                                
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip you want to leave?")
                }
                Section {
                    Text(total, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .background(tipPercentage == 0 ? .red: .clear)
                } header: {
                    Text("Total")
                        
                }
                
                Section {
                    Text(totalPerPerson , format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSpit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
