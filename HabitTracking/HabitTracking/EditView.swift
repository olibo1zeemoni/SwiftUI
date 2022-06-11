//
//  EditView.swift
//  HabitTracking
//
//  Created by Olibo moni on 11/04/2022.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var activity: Activities
    var index: Int
    
    var body: some View {
        
        NavigationView {
            Form {
                Section{
                    TextField("name", text: $activity.activities[index].name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextField("detail", text: $activity.activities[index].detail)
                        .lineLimit(0)
                } header: {
                    Text("Detail")
                }
                
                Section {
                    Picker("Priority", selection: $activity.activities[index].priority) {
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
                       // save()
                        withAnimation {
                            activity.activities.insert(activity.activities[index], at: index)
                            dismiss()
                            
                        }
                       
                    }
                }
            }
            .listStyle(.automatic)
        }
        
        .ignoresSafeArea()
   
}
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(activity: Activities(), index: 1)
    }
}
