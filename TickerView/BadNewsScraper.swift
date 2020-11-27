//
//  BadNewsScraper.swift
//  TickerView
//
//  Created by Dan Moore on 11/24/20.
//

import Foundation
import Combine
import Foundation
import Combine

extension String {
    func replace(regex: String, with newString: String) -> String {
        var copy = self.copy() as! String
        
        while let range = copy.range(of: regex, options: .regularExpression) {
            copy.replaceSubrange(range, with: newString)
        }
        
        return copy
    }
}

struct BadNewsScraper {
    
    static func getBadNews() -> Future<String, Error> {
        let url = URL(string: "https://www.newser.com")!
        let urlSession = URLSession(configuration: .default)
        return Future { promise in
            let task = urlSession.dataTask(with: url) { data, _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let htmlString = String(decoding: data ?? Data(), as: UTF8.self)
                    let result = htmlString
                        .replace(regex: "^[\\s\\S]*BEGIN: StoryGrid", with: "")
                        .replace(regex: "END: StoryGrid[\\s\\S]*$", with: "")
                        .components(separatedBy: "alt=\"")
                        .dropFirst()
                        .map { $0.replace(regex: "\"[\\s\\S]*$", with: "") }
                        .dropLast()
                        .randomElement() ?? ""
                    
                    promise(.success(result))
                }
            }
            task.resume()
        }
    }
    
}
