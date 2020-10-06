//
//  Manager.swift
//  refactoring
//
//  Created by Sousuke Ikemoto on 2020/10/06.
//

import Foundation
import UIKit

class Manager{
    private let client: GithubAPIClient
    private var repositories: [Repository]?
    
    var majorRepositories: [Repository] {
        guard let repositories = self.repositories else {return []}
        return repositories.filter{ $0.stargazersCount >= 10}
    }
    
    
    init() {
        self.client = GithubAPIClient()}
    
    func load(user: String, completion: @escaping () -> Void){
        self.client.fetchRepositories(text: user,handler: { ([T]?) in
            <#code#>
        }){ (repositories) in
            self.repositories = repositories
            completion()
        }
    }
}
