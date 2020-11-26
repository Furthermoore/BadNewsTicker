//
//  BadNewsTicker.swift
//  BadNewsTicker
//
//  Created by Dan Moore on 11/25/20.
//

import WidgetKit
import SwiftUI
import Intents
import Combine

let snapshotContent = BadNewsContent(headline: "You suck!")

struct BadNewsContent: Codable, TimelineEntry {
  var date = Date()
  let headline: String
}

class Provider: IntentTimelineProvider {
    
    private var timelineCancellable: AnyCancellable?
    private let queue = DispatchQueue(label: "com.danmoore.BadNewsTicker.network")
    
    func placeholder(in context: Context) -> BadNewsContent {
        snapshotContent
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (BadNewsContent) -> ()) {
        completion(snapshotContent)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
        timelineCancellable = BadNewsScraper.getBadNews().map {
            Timeline(entries: [Entry(headline: $0)], policy: .after(refreshDate))
        }
        .replaceError(with: Timeline(entries: [Entry(headline: "Errr")], policy: .after(refreshDate)))
        .subscribe(on: queue)
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: completion)
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

