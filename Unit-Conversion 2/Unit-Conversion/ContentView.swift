//
//  ContentView.swift
//  Unit-Conversion
//
//  Created by Olibo moni on 18/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var length1 = ""
    @State private var unit1 = 0
    @State private var unit2 = 0
    @FocusState private var unitIsFocused: Bool

    
    enum Unit: String, CaseIterable {
        case m
        case km = "Km"
        case ft = "Ft"
        case yards
        case miles

        var unitLength: UnitLength {
            switch self {
            case .m: return UnitLength.meters
            case .km: return UnitLength.kilometers
            case .ft: return UnitLength.feet
            case .yards: return UnitLength.yards
            case .miles: return UnitLength.miles
            }
        }
    }
     
    let lengthUnit = Unit
        .allCases
        .compactMap { $0.rawValue }
    
    
    var length2: Double {
        guard let length1 = Double(self.length1) else {
            return 0
        }
        guard let unit1 = Unit(rawValue: lengthUnit[self.unit1]) else {
            return 0
        }
        guard let unit2 = Unit(rawValue: lengthUnit[self.unit2]) else {
            return 0
        }
        return Measurement(value: length1, unit: unit1.unitLength
        )
        .converted(to: unit2.unitLength)
        .value
        
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("From", selection: $unit1) {
                        ForEach(0..<lengthUnit.count) {
                            Text(self.lengthUnit[$0])
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("First Unit")
                }
                Section {
                    TextField("Enter value", text: $length1)
                        .keyboardType(.decimalPad)
                        .focused($unitIsFocused)
                }
                
                Section {
                    Picker("To", selection: $unit2) {
                        ForEach(0..<lengthUnit.count) {
                            Text(self.lengthUnit[$0])
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Second Unit")
                }
                Section {
                    //Text(length2.formatted())
                    Text("\(length2, specifier: "%.3f")")
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


//
//    var formatter: MeasurementFormatter {
//            let fmt = MeasurementFormatter()
//            fmt.unitOptions = .providedUnit
//            fmt.unitStyle = .short
//            return fmt
//        }
