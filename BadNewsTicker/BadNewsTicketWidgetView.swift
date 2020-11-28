//
//  BadNewsTicketWidgetView.swift
//  BadNewsTickerExtension
//
//  Created by Dan Moore on 11/25/20.
//

import SwiftUI
import UIKit
import Combine
import CoreML

struct BadNewsTickerWidgetView : View {
    
    @Environment(\.widgetFamily) var family
    
    private let headline: String
    
    private let mlModel = try! IMDBReviewClassifier(configuration: MLModelConfiguration())
            
    init(headline: String) {
        self.headline = headline
    }
    
    func colorFor(headline: String) -> Color {
        let sentiment = (try? mlModel.prediction(text: headline))?.label ?? ""
        if sentiment == "Negative" {
            return .red
        } else if sentiment == "Positive" {
            return .green
        } else {
            return .white
        }
    }
        
    var fontSize: CGFloat {
        switch family {
        case .systemSmall: return 10
        case .systemMedium: return 20
        case .systemLarge: return 25
        default: return 30
        }
    }
    
    var body: some View {
        Text(headline)
            .font(Font.custom("DigitaldreamFatSkew", size: fontSize))
            .foregroundColor(colorFor(headline: headline))
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .lineSpacing(8)
            .padding()
            .opacity(headline.isEmpty ? 0 : 1)
    }
}

struct BadNewsTickerWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BadNewsTickerWidgetView(headline: "OOH YEAH")
    }
}
