//
//  DetailView.swift
//  iMeet
//
//  Created by Olibo moni on 21/05/2022.
//

import SwiftUI

struct DetailView: View {
     var person: Person
    @State private var viewMap = "Image"
    private let subViews = ["Image", "Map"]
    
    var body: some View {
       
        VStack {
            Picker("Switch views", selection: $viewMap) {
                ForEach(subViews, id:\.self){
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            Spacer(minLength: 80)
            
            if viewMap == "Image" {
                VStack {
                   // ZStack {
                        person.image
                            .resizable()
                            .scaledToFit()
                    //}
                    Spacer()
                   
                }
                .ignoresSafeArea(.container, edges: .top)
            } else {
                    MapView(person: person)
            }
            
        }
        .navigationTitle("\(person.firstName) \(person.lastName)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person.example)
    }
}
