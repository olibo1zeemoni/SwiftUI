//
//  WheelView.swift
//  rollGame
//
//  Created by Olibo moni on 03/06/2022.
//

import SwiftUI

struct WheelView: View {
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var value1 = 90
    @State private var value2 = 0
    @State private var value3 = 0
    @State private var value4 = 0
    @State private var value5 = 0
    @State private var value6 = 0
    @State private var value7 = 0
    @State private var value8 = 0
    @State private var value9 = 0
    @State private var startRoll = false
    var total: Int {
        value1 + value2 + value3 + value4 + value5 + value6 + value7 + value8 + value9
    }
    
    @State private var counter = 30
    let gradient = AngularGradient(gradient: Gradient(colors: [Color.green, Color.yellow, Color.red]),
                                   center: .center, angle: Angle(degrees: 0))
    let column =  [ GridItem(.adaptive(minimum: 120, maximum: 140)),
                    GridItem(.adaptive(minimum: 120, maximum: 140)),
                    GridItem(.adaptive(minimum: 120, maximum: 140))
        
    ]
    
    var body: some View {
        // could have used DispatchQueue.main.async { }
        
        VStack {
            LazyVGrid(columns: column, alignment: .center, spacing: 10) {
                CardView(sides: value1)
                CardView(sides: value2)
                CardView(sides: value3)
                CardView(sides: value4)
                CardView(sides: value5)
                CardView(sides: value6)
                CardView(sides: value7)
                CardView(sides: value8)
                CardView(sides: value9)
              
                
                
            }
            
            Text(total.formatted())
                .font(.system(size: 40, weight: .bold, design: .rounded))
           
                .onReceive(timer) { _ in
                    withAnimation {
                        
                        start()
                        
                        
                        
                      
                    }
                   
            }
            
            Button(startRoll ? "Stop" : "Start") {
                startRoll.toggle()
            }
            .padding()
        }
    }
    
    func start(){
        guard startRoll else { return }
        self.value1 = Int.random(in: 1...100)
        self.value2 = Int.random(in: 1...90)
        self.value3 = Int.random(in: 1...80)
        self.value4 = Int.random(in: 1...70)
        self.value5 = Int.random(in: 1...60)
        self.value6 = Int.random(in: 1...50)
        self.value7 = Int.random(in: 1...40)
        self.value8 = Int.random(in: 1...30)
        self.value9 = Int.random(in: 1...20)
        counter -= 1
        if counter == 0{
            //self.timer.upstream.connect().cancel()
            startRoll = false
            counter = 30
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView()
    }
}

struct CPUClip: Shape {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let c = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: c)
        path.addArc(center: c,
                    radius: rect.width/2.0,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: (pct/100.0) * 360), clockwise: false)
        
        path.closeSubpath()
        return path
    }
}


//Circle()
//
//    .stroke(lineWidth: 3)
//    .foregroundColor(.primary)
//    .background(Circle().fill(gradient).clipShape(CPUClip(pct: Double(value1))))
//    .frame(width: 200)
//    .shadow(radius: 4)
