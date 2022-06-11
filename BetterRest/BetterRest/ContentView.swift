//
//  ContentView.swift
//  BetterRest
//
//  Created by Olibo moni on 24/03/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        //String(format: "Hours : %.2f", sleepAmount)
        NavigationView {
                Form {
                    VStack(alignment: .leading, spacing: 0){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    .padding()
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...8, step: 0.25)
                    }
                    .padding()
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    }
                    .padding()
                    
                }
                .navigationTitle("Better Rest")
                .toolbar {
                    
                    Button("Calculate", action: calculateBedtime)
                }
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("Ok") { }
                } message: {
                    Text(alertMessage)
                }
          }
    }
    
    func calculateBedtime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "You're ideal bedtime is "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            // Something went wrong!
            alertTitle = "Error"
            alertMessage = "v"
        }
        showAlert = true
    }
    
    
    func exampleDates(){
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
        print(range)
        
        //create date from componets
        var component = DateComponents()
        component.hour = 8
        component.minute = 30
        let date = Calendar.current.date(from: component) ?? Date.now
        
        //read date from component
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = component.hour ?? 0
        let minute = component.minute ?? 0
        Text(date, format: .dateTime.hour().minute())
    }
    
   
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
