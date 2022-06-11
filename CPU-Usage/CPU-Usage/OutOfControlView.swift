//
//  OutOfControlView.swift
//  CPU-Usage
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct OutOfControlView: View {
    @State private var counter = 0
  
   
    
    var body: some View {

        DispatchQueue.main.async {
            self.counter += 1
        }
        
       
       return  Text("Computed Times\n\(counter)").multilineTextAlignment(.center)
            
         
    
    }
    
   
}

struct OutOfControlView_Previews: PreviewProvider {
    static var previews: some View {
        OutOfControlView()
    }
}
