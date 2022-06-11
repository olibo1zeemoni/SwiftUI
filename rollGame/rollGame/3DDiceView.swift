//
//  3DDiceView.swift
//  rollGame
//
//  Created by Olibo moni on 01/06/2022.
//

import SwiftUI
import SceneKit

struct _DDiceView: View {
    @State var models = [
                        Model(name: "Six", modelName: "Die.usdz", details: "Six sided game for for everyday fun")
    ]
    
    @State private var index = 0
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            SceneView(scene: SCNScene(named: models[index].modelName), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 4)
                
            ZStack {
                
                // Forward and backward buttons...
                
                HStack{
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            if index > 0{
                                
                                index -= 1
                            }
                        }
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == 0 ? 0.3 : 1)
                    })
                    .disabled(index == 0 ? true : false)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            if index < models.count{
                                
                                index += 1
                            }
                        }
                        
                    }, label: {
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 35, weight: .bold))
                        // disabling button when no other data ....
                            .opacity(index == models.count - 1 ? 0.3 : 1)
                    })
                    .disabled(index == models.count - 1 ? true : false)
                }
                
                Text(models[index].name)
                    .font(.system(size: 45, weight: .bold))
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,30)
            
            //Details
            VStack(alignment: .leading, spacing: 15, content: {
                
                Text("About")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(models[index].details)
            })
            .padding(.horizontal)
            
            Spacer(minLength: 100)
            Spacer()
        }
    }
}


struct _DDiceView_Previews: PreviewProvider {
    static var previews: some View {
        _DDiceView()
    }
}
