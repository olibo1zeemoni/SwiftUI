//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Olibo moni on 21/03/2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .font(.largeTitle)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    
    
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
        
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitle() ->some View {
        modifier(BlueTitle())
    }
}

struct WaterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View{
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .padding(5)
                .background(.black)
                .foregroundColor(.white)
        }
    }
}

extension View {
    
    func waterMarked(with text: String)-> some View {
        modifier(WaterMark(text: text))
    }
}

extension View {
    func titleStyle()-> some View {
        modifier(Title())
    }
    
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        ForEach(0..<rows, id: \.self) {  row in
            HStack {
                ForEach(0..<columns, id: \.self) { column in
                    content(row, column)
                    
                }
            }
        }
    }
    
}




struct ContentView: View {
    
    var body: some View {
              VStack {
                  Text("Views and Modifiers")
                      .blueTitle()
                      Spacer()
        //            CapsuleText(text: "First")
        
        //            CapsuleText(text: "Second")
        //            Text("Third")
        //                .modifier(Title())
        //            Text("Fourth")
        //                .titleStyle()
        //            Color.blue
        //                .frame(width: 400, height: 400)
        //                .waterMarked(with: "hackingWithSwift")
        //NavigationView{
        GridStack(rows: 4, columns: 4) { row, col in
            // HStack {
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row)C\(col)")
            //   }
            
                }
        Spacer()
            }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
