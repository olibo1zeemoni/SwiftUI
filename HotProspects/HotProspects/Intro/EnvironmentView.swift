//
//  ContentView.swift
//  HotProspects
//
//  Created by Olibo moni on 23/05/2022.
//

import SwiftUI

class User: ObservableObject {
    @Published var name: String = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("name", text: $user.name)
    }
}

struct DetailView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentView: View {
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            EditView()
            DetailView()
        }
        .environmentObject(user)
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
    }
}
