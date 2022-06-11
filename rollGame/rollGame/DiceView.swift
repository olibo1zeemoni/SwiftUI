//
//  DiceView.swift
//  rollGame
//
//  Created by Olibo moni on 31/05/2022.
//

import SwiftUI



struct DiceView: View {
    var color: Color = .blue
    @State private var die = Dice(sides: 6)
    
   @State private var sides1 = 6
    @State private var sides2 = 6
    @State private var numberOfDice = 2
    @State private var total = 0
    
    var body: some View {
        
      
            Form {
                Section{
                    Picker("Select number of Dice", selection: self.$numberOfDice) {
                        ForEach(1..<7, id:\.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.menu)
                }header: {
                    Text("Select number of dice")
                }
                Section {
                    Picker("Select number of faces", selection: self.$die.sides) {
                        ForEach(1..<7, id:\.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Select number of sides")
                }
                
                Section {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(1..<numberOfDice + 1, id:\.self) { index in
                            Image(systemName: "die.face.\(sides1).fill")
                                .resizable()
                                .frame(width: 100,height: 100, alignment: .center)
                            
                                .foregroundColor(.blue)
                            
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation {
                            rollDice()
                            print("tapped")
                        }
                    }
                } header: {
                    Text("Tap on Die to roll")
                }
               
                Section {
                    Text(String(total))
                }header: {
                    Text("Total")
                }
                
            }
           
         }
    
    func rollDice(){
        sides1 = Int.random(in: 1...die.sides)
        sides2 = Int.random(in: 1...die.sides)
        total = sides1 + sides2
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
