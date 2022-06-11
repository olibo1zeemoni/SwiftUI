//
//  AddBook.swift
//  BookWorm
//
//  Created by Olibo moni on 25/04/2022.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of Book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.author = author
                        newBook.title = title
                        newBook.review = review
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(disableSave())
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func disableSave() -> Bool{
        if author.isEmpty || title.isEmpty || genre.isEmpty {
            return true
        }
        
        return false
    }
    
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
