//
//  ContentView.swift
//  Flashzilla
//
//  Created by Olibo moni on 27/05/2022.
//


import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    @State private var cards = [Card]()
    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var timeRemaining = 100
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
   
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) { wrongCard in
                            withAnimation {
                                removeCard(at: index, wrongCard: wrongCard)
                            }
                        }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button{
                        showingEditScreen = true
                    }label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled{
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, wrongCard: true)
                            }
                        }label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, wrongCard: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("correct")
                        .accessibilityHint("Mark your answer as being Correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active && !cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCard.init)
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
           if let data = UserDefaults.standard.data(forKey: "Cards") {
               if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                   cards = decoded
               } else {
                   print("failed to decode")
               }
           } else {
               print("failed to load data content")
           }
       }

    
    func removeCard(at index: Int, wrongCard: Bool){
        guard index >= 0 else { return }
        cards.remove(at: index)
        if wrongCard {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.cards.insert(cards[index - 1], at: 0)
            }
        }
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {        
        timeRemaining = 100
        isActive = true
        loadData()
    }
}
    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

