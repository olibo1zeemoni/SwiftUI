//
//  ExampleView3.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

class MyObservable: ObservableObject {
    @Published var someValue = "Here's a value!"
}



struct ExampleView3: View {
    var body: some View {
        VStack(spacing: 20) {
            MyView()
            
            MyView()
                .environmentObject(MyObservable())
        }
    }
}

struct ExampleView3_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView3()
    }
}

extension EnvironmentObject {
    var safeToUse: Bool {
        return (Mirror(reflecting: self).children.first(where: { $0.label == "_store" })?.value as? ObjectType) != nil
    }
}

struct MyView: View {
    @EnvironmentObject var model: MyObservable

    var body: some View {

        let txt = _model.safeToUse ? model.someValue : "No Value"
        
        return Text(txt)
    }
}
