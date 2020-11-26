//
//  BadNewsTicker.swift
//  BadNewsTicker
//
//  Created by Dan Moore on 11/25/20.
//

import WidgetKit
import SwiftUI
import Intents

let snapshotContent = BadNewsContent(headline: "You suck!")

struct BadNewsContent: Codable, TimelineEntry {
  var date = Date()
  let headline: String
}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> BadNewsContent {
        snapshotContent
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (BadNewsContent) -> ()) {
        completion(snapshotContent)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
//        var entries: [BadNewsContent] = readContents()
//
//        let currentDate = Date()
//        let interval = 5
//        for index in 0 ..< entries.count {
//            entries[index].date = Calendar.current.date(byAdding: .second,
//                                                        value: index * interval, to: currentDate)!
//        }
        
        
        let entries = [snapshotContent]
      
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct BadNewsTickerEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        BadNewsTickerWidgetView(headline: entry.headline)
    }
}

@main
struct BadNewsTicker: Widget {
    let kind: String = "BadNewsTicker"
    
    let scrubber = BadNewsScraper()

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            BadNewsTickerEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct BadNewsTicker_Previews: PreviewProvider {
//    static var previews: some View {
//        BadNewsTickerEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
