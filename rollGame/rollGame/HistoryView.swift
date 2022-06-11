//
//  HistoryView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var games: Games
    @State private var deleteAll = false
    
    var body: some View {
        NavigationView {
            List {
                if !games.games.isEmpty {

                    ForEach(games.games.indices, id:\.self) { index in
                        HStack {
                            Text("\(index + 1).")
                            Text("\(games.games[index].sides)-sided")
                                .padding(5)
                                .frame(minWidth: 50)
                            
                            Text("  \(games.games[index].numberOfDice) dice")
                                .frame(maxWidth: 200)
                            
                            Text(games.games[index].total == 0 ? "-" : "(\(games.games[index].total)) total")
                        }
//                        .swipeActions(edge: .trailing) {
//                            Button {
//                                games.delete(game)
//                            } label: {
//                                Label("delete", systemImage: "trash")
//                            }
//                            .tint(.red)
//                        }
                    }
                    .onDelete(perform: games.remove(at:))
                    
                } else {
                    Text("No past rolls")
                }
            }
            .alert("Delete All", isPresented: $deleteAll, actions: {
                Button("Cancel", role: .cancel, action: {})

                Button("Delete All", role: .destructive) {
                    withAnimation {
                        games.removeAll()
                        
                    }
                }
                //Button("Cancel", role: .cancel) { }
                
            }, message: {
                Text("Are you sure you want to Delete All")
            })

            .listStyle(.plain)
            .toolbar {
                EditButton()
                    
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                       deleteAll = true
                    } label: {
                        Label("delete all", systemImage: "trash")
                    }
                }
            })
            .navigationBarTitle("History")
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(Games())
    }
}


