//
//  NetworkObserver.swift
//  MuesliSwapTick
//
//  Created by Jan Rajtr on 20.02.2022.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case unknownError
}

enum NetworkCodes: Int {
    case success = 200
}

struct NetworkFetcher {
    
    /*
    var cancellable: Cancellable?
    
    static func performFetch<T:Codable>(url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
     */
    
    static func performFetch<Data: Codable>(
        type:Data,
        endpoint: NetworkingEndpoints) async -> Result<Data, Error>
    {
        
        guard let url = endpoint.url else {
            return .failure(NetworkError.invalidURL)
        }
        do {
            let (data, response)  = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == NetworkCodes.success.rawValue else {
                    return .failure(NetworkError.invalidResponse)
            }
            let givenData = try JSONDecoder().decode(Data.self, from: data)
            return .success(givenData)

        } catch let error {
            return .failure(error)
        }
        
    }
    /*
    func initTimer() {
        cancellable = Timer
                .publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .receive(on: DispatchQueue.global(qos: .background))
                //.assign(to: \.lastUpdated, on: myDataModel)
    }
     */
    
}
