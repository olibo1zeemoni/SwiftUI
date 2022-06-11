//
//  ContentView.swift
//  Moonshot
//
//  Created by Olibo moni on 03/04/2022.
//

import SwiftUI


struct ContentView: View {
    @State private var showingGrid = true
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridView()
                }
                else {
                    ListView()
                }
            }
            .toolbar {
                Toggle("Grid", isOn: $showingGrid)
                    .toggleStyle(SwitchToggleStyle())
                    //.labelsHidden()
                   
        }
            .navigationTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}






//GeometryReader { geo in
//    Image("apollo1")
//        .resizable()
//        .frame(width: 300, height: 300)
//        .frame(width: geo.size.width , height: geo.size.height)
//}
//Button("Decode JSON") {
//                let input = """
//                            {
//                            "name": "Taylor Swift",
//                            "address": {
//                                    "city": "Nashville",
//                                    "street": "555 Taylor Swift Ave"
//                                    }
//                            }
//                            """
//
//    let data = Data(input.utf8)
//    if let decodedData = try? JSONDecoder().decode(User.self, from: data) {
//        print(decodedData.address.street)
//    }
//}
