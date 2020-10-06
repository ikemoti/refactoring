//
//  Model.swift
//  refactoring
//
//  Created by Sousuke Ikemoto on 2020/09/26.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
    }
}

class GithubAPIClient {
    func fetchRepositories<T: Decodable>(text: String, handler: @escaping ([T]?) -> Void){
        guard let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(text)") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url){ (data, _, error) in
            guard let data = data , error == nil  else {
                handler(nil)
                return }
            guard let test = try? JSONDecoder().decode([T].self, from: data) else { return }
            DispatchQueue.main.async {
                
                handler(test)
            }
            
        }
        task.resume()
    }
    
}
