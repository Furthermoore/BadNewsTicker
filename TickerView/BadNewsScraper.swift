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

extension URLSession {
        
    func request(url: URL) -> Future<String, Error> {
        Future { promise in
            let task = self.dataTask(with: url) { data, _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let result = String(decoding: data ?? Data(), as: UTF8.self)
                    promise(.success(result))
                }
            }
            task.resume()
        }
    }
}

struct BadNewsScraper {
    
    static func getBadNews() -> Future<String, Error> {
        let url = URL(string: "https://www.newser.com")!
        let urlSession = URLSession(configuration: .default)
        return urlSession.request(url: url)
    }
    
}

//struct APIClient {
//
//    func run(_ request: URLRequest) -> AnyPublisher<String, Error> { // 2
//        return URLSession.shared
//            .dataTaskPublisher(for: request) // 3
//            .tryMap { result -> String in
//                return String(decoding: result.data, as: UTF8.self) // 5
//            }
//            .receive(on: DispatchQueue.main) // 6
//            .eraseToAnyPublisher() // 7
//    }
//
//}
//
//struct BadNewsScraper {
//
//    static let apiClient = APIClient()
//    static let url = URL(string: "https://www.newser.com")!
//
//    static func fetchBadNews() -> AnyPublisher<String, Error> {
//        let request = URLRequest(url: URL(string: "https://www.newser.com")!)
//        return apiClient.run(request)
//            .eraseToAnyPublisher()
//    }
//
//
//
//    var cancellables = Set<AnyCancellable>()
//
//    var urlSessionDataTask: URLSessionDataTask?
//
//    init() {
//        BadNewsScraper.fetchBadNews()
//            .sink { error in
//                print(error)
//                print("Bad news fetch completed")
//            } receiveValue: { value in
//                print("Bad news received, news = \(value)")
//            }
//            .store(in: &cancellables)
//    }
//
//}
