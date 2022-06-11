//
//  ManualPublishView.swift
//  HotProspects
//
//  Created by Olibo moni on 23/05/2022.
//

import SwiftUI

@MainActor
class DelayedUpdater: ObservableObject {
  // @Published
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManualPublishView: View {
    @StateObject private var delayedUpdater: DelayedUpdater
    
    var body: some View {
        Text("Value is \(delayedUpdater.value)")
    }
    init(){
        self._delayedUpdater = StateObject(wrappedValue: DelayedUpdater())
    }
}

struct ManualPublishView_Previews: PreviewProvider {
    static var previews: some View {
        ManualPublishView()
    }
}
