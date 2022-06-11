//
//  AlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Olibo moni on 31/05/2022.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        VStack(alignment: .leading) {
               ForEach(0..<10) { position in
                   Text("Number \(position)")
                       .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
               }
           }
           .background(.red)
           .frame(width: 400, height: 400)
           .background(.blue)
    }
}

struct AlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
    }
}
