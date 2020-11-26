//
//  ContentView.swift
//  TickerView
//
//  Created by Dan Moore on 11/24/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let badNewsScraper = BadNewsScraper()
            
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let frameRate: Int = 60
    private var counterInx = 0
    private let timerPeriod: TimeInterval
    private let duration: TimeInterval = 10
    
    @State private var tickerOffsetPercentage: CGFloat = 0 // between zero and 1
    
    private func updateScrollOffset() {
        let thisIndex = counterInx
        let offsetBetweenZeroAndOne = Double(thisIndex) / Double(frameRate)
    }
    
    init() {
        self.timerPeriod = 1 / TimeInterval(frameRate)
        self.timer = Timer.publish(every: timerPeriod, on: .main, in: .common).autoconnect()
        
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 30) {
                ForEach((0 ..< 10).indices, id: \.self) { i in
                    Text("You'll see")
                        .font(Font.custom("Digitaldream", size: 40))
                }
                .border(Color.black)
            }
        }
//        .onReceive(timer, perform: { timer in
//            timer.tim
//        })
    }
        
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
