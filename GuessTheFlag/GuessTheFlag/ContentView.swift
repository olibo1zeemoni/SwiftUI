//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Olibo moni on 19/03/2022.
//

import SwiftUI

struct FlagImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            
    }
}

struct ContentView: View {
    @State private var isGameOver = false
    @State private var questionNumber = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showGameOver = false
    
    @State private var countries = ["spain", "uk", "us", "poland", "russia", "france", "nigeria", "italy", "germany", "ireland", "estonia"]
        .shuffled()
    let labels = [
        "estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "france": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "uk": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "us": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0..<3)
  
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            RadialGradient(stops: [
                .init(color: Color( red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text ("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer].capitalized)
                            
                            .font(.largeTitle.weight(.semibold))
                            
                            
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            //action
                            
                            flagTapped(number)
                             
                        } label: {
                            FlagImage(text: countries[number])
                                .accessibilityLabel(labels[countries[number]] ?? "Unknown flag")
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score is \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
               
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion) }
        message: {
            Text ("your score is \(score)")
        
        }
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Restart", action: restart)
            Button("Dismiss", role: .cancel)
            {}.foregroundColor(.red) }
    message: {
        Text ("your final score is \(score)")
    }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that's the \(countries[number]) flag"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion(){
        guard !isGameOver else { return}
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber += 1
        if questionNumber > 7 {
            isGameOver = true
            showGameOver = true
            
        }
    }
    
    func restart(){
        isGameOver = false
        score = 0
        questionNumber = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
