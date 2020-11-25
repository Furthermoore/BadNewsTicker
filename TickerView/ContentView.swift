//
//  ContentView.swift
//  TickerView
//
//  Created by Dan Moore on 11/24/20.
//

import SwiftUI

struct ContentView: View {
    
    let badNewsScraper = BadNewsScraper()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
