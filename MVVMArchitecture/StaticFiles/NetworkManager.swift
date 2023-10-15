//
//  NetworkManager.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct PageModel: Codable {
    let data: [RailModel]
}

struct RailModel: Codable {
    let title, type: String
    let list: [AssetModel]
}

struct AssetModel: Codable {
    let id: Int
    let title, summary: String
    let rating: Double
    let image, backdrop: String
    let type: AssetType
    let url: String
}

enum AssetType: String, Codable {
    case movie = "movie"
    case series = "series"
}

class NetworkManager{
    static let shared = NetworkManager()
    
    init(){}
    
    typealias RailCompletionClosure = ((PageModel?, Error?) -> Void)
    
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
    
    public func fetchMovieData(completion: RailCompletionClosure?) {
        guard let request = createRequest(for: "https://raw.githubusercontent.com/atulkhatri/random/master/bootcamp-home-movies.json") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    public func fetchSeriesData(completion: RailCompletionClosure?) {
        guard let request = createRequest(for: "https://raw.githubusercontent.com/atulkhatri/random/master/bootcamp-home-series.json") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
