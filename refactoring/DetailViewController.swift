//
//  ViewController.swift
//  refactoring
//
//  Created by Sousuke Ikemoto on 2020/09/26.
//

import UIKit

final class DetailViewController: UIViewController {
    
    
    private let imageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let languageLabel: UILabel = .init()
    private let starsLabel: UILabel = .init()
    var test: Repository = .init(id: 0, name: "", description: "", stargazersCount: 0)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setAttributes()
    }
    func setAttributes() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(languageLabel)
        view.addSubview(starsLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = test.name
        languageLabel.text = test.description
        starsLabel.text = "\(test.stargazersCount)"
        
        NSLayoutConstraint.activate([
            starsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            starsLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
