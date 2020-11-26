//
//  BadNewsTicketWidgetView.swift
//  BadNewsTickerExtension
//
//  Created by Dan Moore on 11/25/20.
//

import SwiftUI
import UIKit
import Combine

struct BadNewsTickerWidgetView : View {
    
    @Environment(\.widgetFamily) var family
    
    private let headline: String
            
    init(headline: String) {
        self.headline = headline
    }
        
    var fontSize: CGFloat {
        switch family {
        case .systemSmall: return 10
        case .systemMedium: return 20
        case .systemLarge: return 30
        default: return 30
        }
    }
    
    var body: some View {
        Text(headline)
            .font(Font.custom("DigitaldreamFatSkew", size: fontSize))
            .lineLimit(nil)
            .lineSpacing(20)
            .opacity(headline.isEmpty ? 0 : 1)
    }
}

struct BadNewsTickerWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BadNewsTickerWidgetView(headline: "OOH YEAH")
    }
}
