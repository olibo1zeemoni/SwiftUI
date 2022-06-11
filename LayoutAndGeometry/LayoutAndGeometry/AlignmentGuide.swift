//
//  AlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Olibo moni on 30/05/2022.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct AlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@readTheDocs")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("cropped-george")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("OLIBO MONI")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct AlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuide()
    }
}
