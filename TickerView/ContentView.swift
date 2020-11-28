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
    
    private let fps = 60
    private let timerDurationSeconds = 15
    private let timerInterval: TimeInterval
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init() {
        self.timerInterval = Double(1) / Double(fps)
        self.timer = Timer.publish(every: Double(1) / Double(fps), on: RunLoop.main, in: RunLoop.Mode.common).autoconnect()
    }
    
    @State private var counter = 0
    private func tick() {
        var currentCount = counter
        currentCount += 1
        if currentCount == (fps * timerDurationSeconds) - 1 {
            counter = 0
        } else {
            counter = currentCount
        }
        if let gw = contentWidth {
            self.xOffset = xOffset(using: gw)
        }
    }
        
    private func xOffset(using width: CGFloat) -> CGFloat {
        (CGFloat(counter) / CGFloat(fps * timerDurationSeconds)) * width * -1.0
    }
    
    @State private var xOffset: CGFloat = .zero
    @State private var contentWidth: CGFloat? = nil
            
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 30) {
                        Spacer(minLength: geo.size.width)
                        ForEach((0 ..< 10).indices, id: \.self) { i in
                            Text("You'll see")
                                .font(Font.custom("DigitaldreamFatSkew", size: 80))
                        }
                    }
                    .offset(CGSize(width: self.xOffset, height: 0))
                    .overlay(GeometryReader { g in
                        Color.clear.onAppear { self.contentWidth = g.size.width }
                    })
                }
                .onReceive(timer) { timer in
                    tick()
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
