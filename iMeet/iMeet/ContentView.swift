//
//  ContentView.swift
//  iMeet
//
//  Created by Olibo moni on 21/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var people = [Person]()
    @State private var showAddView = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var image: UIImage?
    @State private var longitude: Double = 0.0
    @State private var latitude: Double = 0.0
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people.sorted()) {person in
                    NavigationLink {
                        DetailView(person: person)
                    } label: {
                        HStack(alignment: .center) {
                            person.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Spacer()
                            Text("\(person.firstName) \(person.lastName)")
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: removeItems(at:))
            }
            .listStyle(.plain)
            .sheet(isPresented: $showAddView, onDismiss: addPerson) {
                AddView(firstName: $firstName, lastname: $lastName, inputImage: $image, longitude: $longitude, latitude: $latitude)
            }
            .alert(alertTitle, isPresented: $showingAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(alertMessage)
            })
            .navigationTitle("iMeet")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showAddView = true
                    }label: {
                        Label("Add Person", systemImage: "plus")
                    }
                }
            }
        }
        
        .onAppear { loadData() }
    }
    func addPerson(){
        guard !firstName.isEmpty && !lastName.isEmpty && image != nil else { return }
        let newPerson = Person(firstName: firstName, lastName: lastName, id: UUID(), uiImage: image!, longitude: longitude, latitude: latitude)
        people.append(newPerson)
        
        //reset state
        firstName = ""
        lastName = ""
        image = nil
        
        saveData()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
        
        // if data is available, try loading it
        if let data = try? Data(contentsOf: fileUrl) {
            do {
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                alertTitle = "Loading error"
                alertMessage = "Could not load data"
                self.showingAlert = true
            }
        }
    }
    
    func saveData() {
        do {
            let fileUrl = getDocumentsDirectory().appendingPathComponent("People")
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            alertTitle = "Saving error"
            alertMessage = "Could not save data"
            self.showingAlert = true
        }
    }
   
    func removeItems(at offsets: IndexSet){
        people.remove(atOffsets: offsets)
        saveData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
