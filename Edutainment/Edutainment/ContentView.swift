//
//  ContentView.swift
//  Edutainment
//
//  Created by Olibo moni on 30/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isGameOver = false
    @State private var numbers = [2...12]
    @State private var value = 2
    @State private var numberOfQuestions = 5
    @State private var questionNumber = 1
    @State private var answer = ""
    @State private var score = 0
    @State private var showAlert = false
    @State private var enabled = false
    @State private var animationAmount = 1.0
    
    @State private var secondNumber = Int.random(in: 2...12)
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                  //  List {
                    Form {
                        Section("Difficulty Level") {
                                Stepper( value: $value, in: 2...12 , step: 1){
                                    Text("Level \(value)")
                                }
                                
                        }
                       // .background(.gray)
                    }
                    .foregroundColor(.red)
                    .padding(10)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    VStack {
                        Section ("Number of Questions") {
                                Stepper( value: $numberOfQuestions, in: 2...20 , step: 1){
                                    Text("Total Questions: \(numberOfQuestions)")
                                }
                                
                        }
                    }
                    .background(.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Section ("Questions"){
                                Text("\(value) * \(secondNumber)")
                            
                                .frame(width: 300, height: 300)
                                .background(.yellow)
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 77, weight: .heavy, design: .rounded))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .rotation3DEffect(.degrees(animationAmount != 181 ? animationAmount : 0), axis: (x: 0, y: 1, z: 0),anchor:.center , perspective: 2)
                            
                            TextField("Answer", text: $answer)
                                .keyboardType(.default)
                                .onSubmit {
                                    withAnimation{
                                        checkAnswer()
                                       
                                    }
                                   // animationAmount + 1.5
                                }
                                
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 77, weight: .heavy, design: .rounded))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        .animation(.interpolatingSpring(stiffness: 10, damping: 2), value: showAlert)
                        
                    //}
                    
                }
                .padding()
                
            }
            
            
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Continue", action: newQuestion)
            } message: {
                Text(alertMessage)
            }
            .alert("Game Over", isPresented: $isGameOver) {
                Button("Restart") {
                    restart()
                }
                
            } message: {
                Text("Final Score \(score)")
            }
            .navigationTitle("Edutainment")
        }
        .foregroundColor(.white)
        .font(.system(size: 20, weight: .heavy, design: .monospaced))
    }
    
    func newQuestion() {
        guard !isGameOver else { return }
        
        secondNumber = Int.random(in: 2...12)
        withAnimation{ animationAmount += 60
        }
    }
    
    func checkAnswer(){
        
        let correctAnswer = value * secondNumber
        if Int(answer) == correctAnswer {
            //print("correct")
            alertMessage = "Correct"
            alertTitle = "👍"
            score += 1
        } else {
            //print("wrong")
            alertMessage = "Wrong"
            alertTitle = "😫"
        }
        
        if questionNumber >= numberOfQuestions {
            isGameOver = true
            return
        }
        showAlert = true
        answer = ""
        questionNumber += 1
    }
    
    func restart(){
        isGameOver = false
        questionNumber = 1
        secondNumber = Int.random(in: 2...12)
        answer = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
