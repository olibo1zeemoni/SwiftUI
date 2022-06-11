//
//  GeometryReader.swift
//  LayoutAndGeometry
//
//  Created by Olibo moni on 30/05/2022.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct GeometryReaderView: View {
    var body: some View {
        OuterView()
                    .background(.red)
                    .coordinateSpace(name: "Custom")
    }
}

struct GeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
