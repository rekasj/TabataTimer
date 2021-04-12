//
//  TImerView.swift
//  TABATIMER
//
//  Created by Jakub Rękas on 03/04/2021.
//

import SwiftUI

struct TimerView: View {
    
    @State private var progress: Double = 0.0
    @State private var btnName: String = "START"
    @State private var round: Int = 1
    @State private var circleColor: Color = .green
    @State private var state: Bool = true
    
    var body: some View {
        
        VStack{
            Text("Runda: \(round)")
                .font(.largeTitle)
                .offset(y: 100)
            
            ZStack{
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.2)
                
                Circle()
                    .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(self.progress))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(circleColor)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(Animation.linear(duration: 1.0))
                if circleColor == .green {
                    Text(String(format: "%.0f%", min(self.progress, 1.0)*20.0))
                        .font(.largeTitle)
                        .bold()
                }
                if circleColor == .red {
                    Text(String(format: "%.0f%", min(self.progress, 1.0)*10.0))
                        .font(.largeTitle)
                        .bold()
                }
                
                
                Button("\(self.btnName)"){
                    
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        
                        
                        if state {
                            circleColor = .green
                            self.progress += 0.05
                            if self.progress >= 1 {
                                self.progress = 0
                                state = false
                            }
                        }
                        else {
                            circleColor = .red
                            self.progress += 0.1
                            if self.progress >= 1 {
                                round += 1
                                self.progress = 0
                                state = true
                            }
                        }
                        
                    }
                    if btnName == "START" {
                        btnName = "STOP"
                    }
                    else {
                        btnName = "START"
                        
                    }
                }.offset(y: 300)
            }.padding()
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .previewDevice("iPhone 11")
    }
}
