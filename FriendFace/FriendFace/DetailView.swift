//
//  DetailView.swift
//  FriendFace
//
//  Created by Olibo moni on 10/05/2022.
//

import SwiftUI

struct DetailView: View {
    
    var user: User
    
    var body: some View {
       // VStack(alignment: .leading, spacing: 30) {
       
        Form {
                Section("USER STATUS"){
                    Text(user.isActive ? "Online" : "Offline")
                }
                
                Section {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text("\(user.age)")
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("\(user.email)")
                    }
                    
                    HStack {
                        Text("Address")
                        Spacer()
                        Text("\(user.address)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Date Joined")
                        Spacer()
                        Text(user.registered, style: .date)
                    }
                }
                
                Section {
                    Text(user.about)
                } header: {
                    Text("about")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        ForEach(user.friends, id:\.id) { friend in
                            Text(friend.name)
                        }
                    }
                } header: {
                    Text("friends")
                }
                
                Section("TAGS") {
                    VStack(alignment: .leading, spacing: 0){
                        ForEach(user.tags, id:\.self) {
                            Text($0)
                        }
                    }
                }
            
            Section {
                Text("\(user.id)")
                    .font(.caption)
            }header: {
                Text("user id")
                  
            }
               
            }
            .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
