//
//  ContentView.swift
//  FriendFace
//
//  Created by Olibo moni on 10/05/2022.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "B")) var cachedUsers: FetchedResults<CachedUser>
   
    
     @State var users = [User]()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(user.name)
                                    .font(Font.title)
                                Spacer()
                                Text(user.isActive ? "Online" : "Offline")
                                    .foregroundColor(user.isActive ? .green : .red)
                            }
                            Text(user.email)
                                .opacity(0.8)
                                .font(.caption)
                            Text("\(user.age)")
                            
                
                        }
                    }

                    
                }
            }.listStyle(.plain)
                .task {
                   await loadData()
                    await MainActor.run{
                        //try? moc.save()
                    }
                }
                //.onAppear(perform: loadData)
                .navigationTitle("Friend Face")
        }
        
    }
    
    func loadData() async{
        guard users.isEmpty else { return }
        print("downloading data")
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                 do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                     
                     guard let httpResponse = response as? HTTPURLResponse else { return}
                     if httpResponse.statusCode == 200 { print("data received")
                     } else {
                         print("Bad response")
                     }
        
                    let decoder = JSONDecoder()
                     decoder.userInfo[CodingUserInfoKey.context!] = self.moc
                     decoder.dateDecodingStrategy = .iso8601
        
        
                     if let decodedResponse = try? decoder.decode([User].self, from: data) {
                         users = decodedResponse
                         try moc.save()
                     }
                    
                 } catch {
                     print(error.localizedDescription)
                 }
        
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let userData = data else {
//                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
//                return
//            }
//
//            let userDecoder = JSONDecoder()
//
//            userDecoder.dateDecodingStrategy = .iso8601
//
//            do {
//                users = try userDecoder.decode([User].self, from: userData)
//                return
//            } catch {
//                print("Decoding Failed: \(error)")
//            }
//
//            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown Error")")
//
//        }.resume()

        
    }
}


