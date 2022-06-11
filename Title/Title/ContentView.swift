//
//  ContentView.swift
//  Title
//
//  Created by Olibo moni on 22/03/2022.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        NavigationView {
            
            content
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "sun.min.fill")
                                .foregroundColor(.blue)
                               
                            Text(text)
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                
                        }
                        .padding()
                        
                    }
                }
                //.navigationTitle("Hello")
                
        }
    }
}

extension View {
    func blueTitle(_ text: String) -> some View {
        modifier(BlueTitle(text: text))
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}

let agents = ["Cyril", "Lana", "Pam", "Sterling"]


struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(agents, id: \.self) { //agent in
                    Text($0)
                    
                }
        Text("Hello, world!")
                    .padding()
//                        .navigationTitle(Text("Hello"))
//                        .navigationBarColor(backgroundColor: .red, titleColor: .blue)
//                        .navigationBarTitleDisplayMode(.inline)
//                        .blueTitle("Hello")
//                        .navigationTitle("another")
            }
        }
        
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
