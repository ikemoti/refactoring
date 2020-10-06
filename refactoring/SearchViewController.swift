//
//  SearchViewController.swift
//  refactoring
//
//  Created by Sousuke Ikemoto on 2020/09/26.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    private let searchBar: UISearchBar = .init()
    private let tableView: UITableView = .init()
    private let navigationBar: UINavigationBar = .init()
    var repositories: [Repository] = []
    var fetchedrepository: Repository = .init(id: 0, name: "", description: "", stargazersCount: 0)
    var idx: Int?
    
    var task: URLSessionTask?
    var word: String = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAttributes()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    //APIクライアントちゃんと作る
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索")
        word = searchBar.text!
        if word.count == 1 {
            guard let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(word)") else {return}
            task = URLSession.shared.dataTask(with: url) { [self] (data, res, err) in
                if let data = data {
                    guard let test = try? JSONDecoder().decode([Repository].self, from: data) else {return}
                    self.repositories = test
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
          }
          task?.resume()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = .init()
        let rp: Repository = repositories[indexPath.row]
        cell.textLabel?.text = rp.name
        cell.detailTextLabel?.text = rp.name
        cell.tag = indexPath.row
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idx = indexPath.row
        fetchedrepository = repositories[indexPath.row]
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let nextVC = segue.destination as? DetailViewController
            nextVC?.test = fetchedrepository
        }
    }
}
// viewController + Layout
extension  SearchViewController {
    func setLayout() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44),
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setAttributes() {
        let navItem: UINavigationItem = UINavigationItem(title: "タイトル")
        navigationBar.pushItem(navItem, animated: true)
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        
    }
    
}
