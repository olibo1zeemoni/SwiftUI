//
//  EditCard.swift
//  Flashzilla
//
//  Created by Olibo moni on 29/05/2022.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards: [Card] = []
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new Card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                Section("Cards") {
                    ForEach(0..<cards.count, id:\.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Spacer()
                            Text(cards[index].answer)
                        
                        }
                       
                    }
                    .onDelete(perform: removeCards)
                }
                
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
            .navigationBarTitle("Edit Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done", action: done)
                }
            }
        }
    }
    
    func done(){
        dismiss()
    }
    
    func loadData() {
           if let data = UserDefaults.standard.data(forKey: "Cards") {
               if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                   cards = decoded
               }
           } else {
               print("failed to load edit")
           }
       }

       func saveData() {
           if let data = try? JSONEncoder().encode(cards) {
               UserDefaults.standard.set(data, forKey: "Cards")
           }
           else {
               print("failed to save edit")
           }
       }
    
    func addCard(){
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let newCard = Card(prompt: newPrompt, answer: newAnswer)
        cards.insert(newCard, at: 0)
        saveData()
        newAnswer = ""
        newPrompt = ""
    }
    
    func removeCards(at offsets: IndexSet){
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
}

struct EditCard_Previews: PreviewProvider {
    static var previews: some View {
        EditCard()
    }
}
