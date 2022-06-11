//
//  ContentView.swift
//  BookWorm
//
//  Created by Olibo moni on 24/04/2022.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    
    var body: some View {
        NavigationView {
            List { ForEach(books ) { book in
                NavigationLink {
                    DetailView(book: book)
                    //AddBook()
                } label: {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating == Int16(1) ? .red : .white)
                            
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
            }
            .onDelete(perform: deleteBook(at:))
                
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBook()
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
