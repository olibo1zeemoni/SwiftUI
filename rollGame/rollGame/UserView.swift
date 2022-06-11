//
//  UserView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var name: String
}

class Users: ObservableObject {
    @Published var users: [User] = [User(name: "Ama"), User(name: "Akos")]
}

struct EditView: View {
    @EnvironmentObject var users: Users
    var body: some View {
        List {
            ForEach(users.users.indices, id: \.self) { index in
                TextField("names", text: $users.users[index].name)
                    
            }
        }
    }
        
}

struct DetailView: View {
    @EnvironmentObject var users: Users
    var body: some View {
        List {
            ForEach(users.users) {
                Text($0.name)
            }
        }
    }
}

struct UserView: View {
    @StateObject private var users = Users()
    var body: some View {
        VStack {
            EditView()
            DetailView()
        }
        .environmentObject(users)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
