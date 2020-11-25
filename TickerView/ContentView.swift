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
    
    let rows = 16
    let columns = 16
    
    @State private var activeColumn: Int = 7
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            ZStack {
                VStack(spacing: 10) {
                    ForEach((0..<rows).indices, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach((0..<columns).indices, id: \.self) { column in
                                Color.gray
                            }
                        }
                    }
                }
                HStack(spacing: 10) {
                    ForEach((0..<columns).indices, id: \.self) { column in
                        VStack(spacing: 10) {
                            if column == activeColumn {
                                ForEach((0..<rows).indices, id: \.self) { row in
                                    Color(Color.RGBColorSpace.sRGB, red: 0, green: 0.7, blue: 0, opacity: 1.0)
                                }
                            } else {
                                ForEach((0..<rows).indices, id: \.self) { row in
                                    Color.clear
                                }
                            }
                        }
                    }
                }
            }
        }
        .aspectRatio(contentMode: .fit)
        .onReceive(timer, perform: { _ in
            activeColumn = activeColumn == 0 ? columns - 1 : activeColumn - 1
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
