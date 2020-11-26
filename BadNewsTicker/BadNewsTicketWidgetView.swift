//
//  BadNewsTicketWidgetView.swift
//  BadNewsTickerExtension
//
//  Created by Dan Moore on 11/25/20.
//

import SwiftUI
import UIKit
import Combine

struct FitSystemFont: ViewModifier {
    var lineLimit: Int
    var minimumScaleFactor: CGFloat
    var percentage: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .font(Font.custom("Digitaldream", size: min(geometry.size.width, geometry.size.height) * percentage))
                .lineLimit(self.lineLimit)
                .minimumScaleFactor(self.minimumScaleFactor)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
}

extension View {
    func fitSystemFont(lineLimit: Int = 1, minimumScaleFactor: CGFloat = 0.01, percentage: CGFloat = 1) -> ModifiedContent<Self, FitSystemFont> {
        return modifier(FitSystemFont(lineLimit: lineLimit, minimumScaleFactor: minimumScaleFactor, percentage: percentage))
    }
}

struct BadNewsTickerWidgetView : View {
    
    private let headline: String
            
    init(headline: String) {
        self.headline = headline
    }
        
    var body: some View {
        Text(headline)
            .fitSystemFont(lineLimit: 2, minimumScaleFactor: 0.1, percentage: 1)
    }
}

struct BadNewsTickerWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BadNewsTickerWidgetView(headline: "OOH YEAH")
    }
}
