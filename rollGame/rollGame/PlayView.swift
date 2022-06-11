//
//  PlayView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI


struct PlayView: View {
    @State private var enabled = false
    @State private var offset = CGSize.zero
    
    var columns : [GridItem] = [ GridItem(.adaptive(minimum: 120, maximum: 140)),
                                 GridItem(.adaptive(minimum: 120, maximum: 140)),
                                 GridItem(.adaptive(minimum: 120, maximum: 140))
                                ]
    var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @EnvironmentObject var games: Games
    @State private var newTotal:Int = 0
    @State private var array: [Int] = []
    @State private var animationAmount = 0.0
    
    @State private var startRoll = false
    @State private var counter = 15
    
    
    let generator = UIFeedbackGenerator()
    
    var isArrayEmpty: Bool {
        if games.games.isEmpty {
            return true
        } else {
            return false
        }
        
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                Text(startRoll || !isArrayEmpty ? "Total \(newTotal)" : "-")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .animation(.default, value: newTotal)
                    
                
                VStack(spacing: 10) {
                    if games.games.isEmpty {
                        Text("Select Type and number of Dice in Settings")
                            .multilineTextAlignment(.center)
                        
                    }
                    else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<array.count, id:\.self) { index in

                                
                                CardView(sides: array[index])
                                    .offset(enabled ? offset : .zero)
                                    .animation(Animation.linear(duration: 0.1).repeatCount(10).speed(100), value: enabled)
//                                    .animation(Animation.linear(duration: 0.2).repeatCount(100).speed(1000), value: enabled)
                                
                                
                                    
                            }
                        }
                       
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 400)
                .padding([.leading, .trailing])
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                
                Button {
                    startRoll.toggle()
                    enabled.toggle()
                    offset = CGSize(width: 5, height: 5)
                } label: {
                    Label(startRoll ? "Stop" : "Roll", systemImage: "dice.fill")
                        .tint(.white)
                }
                .frame(width: 150)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .onAppear(perform: generator.prepare)
            .navigationTitle("Roll Game")
        }
        .onReceive(timer) { _ in
            withAnimation {
                start()
            }
        }
        .onAppear {
            guard !games.games.isEmpty else { return }
            array = [Int](repeating: 0, count: games.games[0].numberOfDice)
            newTotal = 0
        }
    }
    
    
    
    
    func start(){
        guard !games.games.isEmpty else { return }
        guard startRoll else { return }
        
        let newGame = Game(id: UUID(), total: 0, numberOfDice: games.games[0].numberOfDice, sides: games.games[0].sides)
        animationAmount += 0.5
        
        for index in 0..<array.count {
            array.remove(at: index)
            let random = Int.random(in: 1...games.games[0].sides)
            array.insert(random, at: index)
            withAnimation {
                newTotal = array.reduce(0, +)
            }
            print("Total of \(array) is \(newTotal)")
        }
        
        
        
        counter -= 1
        if counter == 0{
            //self.timer.upstream.connect().cancel()
            startRoll = false
            counter = 15
            games.games[0].total = newTotal
                       
            
            games.add(newGame)
        }
        
        
        
    }
    
    
    func calculateTotal(){
//        var newArray:[Int] = []
        guard !games.games.isEmpty else { return }
//
//        for _ in 0..<games.games[0].numberOfDice {
//
//            let random = Int.random(in: 1...games.games[0].sides)
//
//                newArray.append(random)
//        }
//       let total = newArray.reduce(0,+)
//        withAnimation {
//            array.removeAll()
//                   array = newArray
//
//        }
//
        print(array)
//        print(total)
//        newTotal = total
//
//        games.games[0].total = total
//
//
        let newGame = Game(id: UUID(), total: 0, numberOfDice: games.games[0].numberOfDice, sides: games.games[0].sides)

        games.add(newGame)
//
//
        
    }
    
    
    
    
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .environmentObject(Games())
    }
}





//                                if games.games[0].sides <= 6 {
//
//                                    SixSidedDiceView(sides: $games.games[0].sides)
//
//                                } else {
//                                    Text("Huge number")
//                                }
