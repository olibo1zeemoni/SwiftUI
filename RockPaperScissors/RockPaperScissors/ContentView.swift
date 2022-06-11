//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Olibo moni on 22/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var container = ["🪨rock", "📃paper", "✂️scissors"]
       // .shuffled()
    @State private var questionNumber = 0
    @State private var showGameOver = false
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var isGameOver = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //Color.blue
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Choose an option")
                        .padding()
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                    VStack {
                        ForEach(0..<3) { number in
                            Button {
                                
                                optionTapped(number: number)
                            } label: {
                                Text(container[number])
                                    .font(.title.weight(.bold))
                                    .foregroundColor(.white)
                                    
                                    .padding(40)
                                    .shadow(color: .black, radius: 15)
                            }
                           // .shadow(radius: 5)
                        }
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    Spacer()
                    
                }
                
                
                .frame(maxWidth: .infinity)
                //.background(.ultraThinMaterial)
                //.clipShape(RoundedRectangle(cornerRadius: 10))
                
                .navigationTitle("Rock Paper Scissors")
                
                
            }
            .alert("Game Over", isPresented: $showGameOver) {
                Button("Restart", action: restart)
                Button("Dismiss", role: .cancel)
                {}.foregroundColor(.red) }
        message: {
            Text ("your final score is \(score) / 10")
        }
    }
        
    }
    
    
    func optionTapped(number: Int){
        if questionNumber > 9 {
            isGameOver = true
            showGameOver = true
            return
        }
        newRound()
        print("computer chose \(container[correctAnswer])")
        questionNumber += 1
       
       
        switch (number, correctAnswer) {
        case(0,1), (1,2), (2,0):
            print("Computer Wins")
            
        case(0,2), (2,1), (1,0):
            print("Player Wins")
            score += 1
            
        default:
            print("Tie")
        }
    }
    
    func restart(){
        isGameOver = false
        score = 0
        questionNumber = 0
        newRound()
    }
    
    func newRound(){
        //container.shuffle()
        guard !isGameOver else { return }
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
