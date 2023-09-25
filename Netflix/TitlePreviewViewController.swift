//
//  TitlePreviewViewController.swift
//  Spotidy
//
//  Created by Artem on 13/09/2023.
//

import UIKit
import WebKit

final class TitlePreviewViewController: UIViewController {

    var movie: Movie?
    
    private let name: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 23, weight: .semibold)
        lbl.textColor = .white
        lbl.text = "AAA"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionName: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = .white
        lbl.text = "AAA"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        setConstraint()
    }
    
    private func initialize() {
        view.backgroundColor = .systemBackground
        view.addSubview(name)
        view.addSubview(descriptionName)
        view.addSubview(webView)
    }
    
    public func configure(_ item: Item, with movie: Movie) {
        self.name.text = movie.originalName ?? "not name"
        self.descriptionName.text = movie.overview ?? "not description"
        
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(item.id?.videoID ?? "fall")") else {return}
        print("MYYY: \(url.absoluteString)")
        webView.load(URLRequest(url: url))
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
        
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            name.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 30),
            
            descriptionName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30),
            descriptionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }


}
