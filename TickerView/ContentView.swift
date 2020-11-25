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
            
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    init() {
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
        Text("You'll see")
            .font(Font.custom("Digitaldream", size: 40))
    }
        
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
