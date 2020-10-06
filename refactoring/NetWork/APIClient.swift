//
//  APIClient.swift
//  refactoring
//
//  Created by Sousuke Ikemoto on 2020/10/06.
//

import Foundation

protocol ApiRequest {
    func send<T: Decodable>(request: Request, completion: @escaping ((Result<T, Error>) -> Void))
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case path = "PATCH"
}

protocol Request {
    var baseURL: URLComponents? { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HttpMethod { get }
    var headerFields: [String: String] {get}
    var requestBody: [String: Any?] { get }
    
}

struct APIClient: ApiRequest {
    func send<T>(request: Request, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        
        var urlComponents = request.baseURL
        urlComponents?.path = request.path
        urlComponents?.queryItems = request.queryItems
        guard let url = urlComponents?.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headerFields
        
        URLSession.shared.dataTask(with: urlRequest){ data, error, responnse in
            if let error = error {
                print("eroor")
            }
        
            
        }
        
    }
}
