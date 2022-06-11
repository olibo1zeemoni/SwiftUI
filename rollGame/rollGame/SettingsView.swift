//
//  SettingsView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var games: Games
    
    @State private var possibleFaces = [4,6,8,10,12,20,100]
    @State private var numberOfDice: Int = 4
    @State private var diceType = 6
    
    
    
    
//    init() {
//        UITableView.appearance().sectionHeaderTopPadding = .zero
//        UITableView.appearance().sectionHeaderHeight = .zero
//
//    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Number of Dice", selection: self.$numberOfDice) {
                        ForEach(1..<10, id:\.self) { number in
                            Text("\(number) Dice")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 200)
                } header: {
                    Text("Number of Dice")
                }
                
                Section {
                    Picker("Dice Type", selection: self.$diceType){
                        ForEach(possibleFaces, id:\.self) { dice in
                            Text("\(dice)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Dice type")
                }
                
            }
            .navigationTitle("Settings")
            .onDisappear {
                let newGame = Game(id: UUID(), total: 0, numberOfDice: numberOfDice, sides: diceType)
                withAnimation {
                    games.add(newGame)
                }
               
            }
            
        }
        
    }
    
   
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Games())
    }
}


//ForEach(0..<numberOfDice, id:\.self) { number in
//    Section {
//        Picker("Select number of faces", selection: $die1Faces) {
//                           ForEach(possibleFaces, id:\.self) { face in
//                               Text(String(face))
//                           }
//                       }
//                       .pickerStyle(.segmented)
//    }header: {
//        Text("Select the number of sides for die \(number + 1) ")
//    }
//
//}
