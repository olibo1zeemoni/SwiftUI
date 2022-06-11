//
//  ContentView.swift
//  HabitTracking
//
//  Created by Olibo moni on 10/04/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var activities : Activities
    @State private var showingSheet = false
    
    @State  var activity: Activity
    
    var body: some View {
            NavigationView {
                List { if activities.activities.isEmpty {
                    Text("You have no activity")
                } else {
                    
                    ForEach(activities.activities.indices){  index in
                        NavigationLink {
                            //EditView(activity: activities, index: index)
                            Text("Edit")
                        } label: {
                            HStack {
                                Text(activities.activities[index].name)
                                
                                Spacer()
                                
                                activities.activities[index].priorityImage
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
                    
                    
                }
                
                .navigationTitle("Habit Tracker")
                .listStyle(.plain)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                                self.showingSheet.toggle()
                            }) {
                                Image(systemName: "plus")
                            })
                                .sheet(isPresented: $showingSheet) {
                                    AddView(activities: activities)
                            }

            }
                       
        }
        
    
    func add(){
     
    }
    
    func delete(at offsets: IndexSet) {
        Activities().activities.remove(atOffsets: offsets)
        Activities().save()
        }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(activities: Activities(), activity: <#Binding<Activity>#>)
//    }
//}

//                .toolbar {
//                    ToolbarItem{
//                        Button{
//                            showingSheet.toggle()
//
//                        }label: {
//                            Image(systemName: "plus")
//                        }
//                        .sheet(isPresented: $showingSheet) {
//                            AddView(activity: activity, activities: activities)
//                        }
//
//                    }
//
//                }
                
