//
//  ResortDetailView.swift
//  SnowSneaker
//
//  Created by Olibo moni on 05/06/2022.
//

import SwiftUI

struct ResortDetailView: View {
    let resort: Resort
    var size: String {
        //["Small", "Medium", "Large"][resort.size - 1]
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Medium"
        default:
            return "Large"
        }
    }
    
    var price: String {
        return String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailView(resort: Resort.example)
    }
}
