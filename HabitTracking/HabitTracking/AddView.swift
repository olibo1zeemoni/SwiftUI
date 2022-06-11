//
//  DetailView.swift
//  HabitTracking
//
//  Created by Olibo moni on 11/04/2022.
//

import SwiftUI

struct AddView: View {
    
   // @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    // @State var activity: Activity
    @ObservedObject var activities: Activities
    @State private var isShowingAlert = false
    @State var name = ""
    @State var detail = ""
    @State var priority = 0
    
    
    var body: some View {
      
            NavigationView {
                Form {
                    Section{
                        TextField("name", text: $name)
                    } header: {
                        Text("Name")
                    }
                    
                    Section {
                        TextField(detail, text: $detail)
                            .lineLimit(0)
                    } header: {
                        Text("Detail")
                    }
                    
                    Section {
                        Picker("Priority", selection: $priority) {
                            Text("1").tag(1)
                            Text("2").tag(2)
                            Text("3").tag(3)
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Priority")
                    }
                    
                    
                    
                }
                .toolbar{
                    ToolbarItem{
                        Button("save"){
                            withAnimation {
                                let activity = Activity(name: name, detail: detail, priority: priority, progress: 0)
                                activities.activities.append(activity)
                                activities.save()
                                
                                //self.presentationMode.wrappedValue.dismiss()
                                dismiss()
                                
                            }
                           
                        }
                    }
                }
                .listStyle(.automatic)
                .navigationTitle("Add New")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            .ignoresSafeArea()
       
    }
    
    func save(){
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}

//@Environment(\.presentationMode) var presentationMode
//let activity = Activity(title: self.title, description: self.description)
//                self.habits.add(activity: activity)
//                self.presentationMode.wrappedValue.dismiss()
