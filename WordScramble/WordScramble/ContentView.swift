//
//  ContentView.swift
//  WordScramble
//
//  Created by Olibo moni on 28/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView{
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(usedWords, id:\.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                                .foregroundColor(.blue)
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "\(newWord) is not a real word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not Possible", message: "You can't spell \(newWord) from \(rootWord)")
            return
        }
        
       
        
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame(){
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWord = try? String(contentsOf: startURL) {
                let allWords = startWord.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load Start.txt from bundle")
        
    }
    
    func isOriginal(word: String)-> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String)-> Bool{
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledWord = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledWord.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}













//
//        List(people, id: \.self) {
//            Text($0)
//        }
//        List(0..<5){
//            Text("List \($0)")
//        }
//        List{
//            Section("Section 1") {
//                Text("Static 1")
//                Text("Static 2")
//
//            }
//            Section("Section2 ") {
//                ForEach(0..<5) {
//                    Text("Dynamic Row \($0)")
//                }
//            }
//            Section("Section 3") {
//                Text("Static 3")
//                Text("Static 4")
//            }
//        }
//        .listStyle(.grouped)
