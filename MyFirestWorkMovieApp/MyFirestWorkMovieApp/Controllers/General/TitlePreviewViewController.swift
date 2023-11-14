//
//  TitlePreviewViewController.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 05.12.2022.
//

import UIKit
import WebKit


class TitlePreviewViewController: UIViewController {
    
    private let titleLable: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22,weight: .bold)
        label.text = "Venom"
        return label
    }()
    
    private let owerviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is zbs movie"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("DownLoad", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webWiew: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webWiew)
        view.addSubview(titleLable)
        view.addSubview(owerviewLabel)
        view.addSubview(downloadButton)
        
        configureConstraints()
    }
     
    
    func configureConstraints() {
        let webViewConstraints = [
            webWiew.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webWiew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webWiew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webWiew.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLableContraints = [
            titleLable.topAnchor.constraint(equalTo: webWiew.bottomAnchor, constant: 20),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let owerviweLabelConstraints = [
            owerviewLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            owerviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            owerviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: owerviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 150),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLableContraints)
        NSLayoutConstraint.activate(owerviweLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

    func configure (with model: TitilePreviewViewModel){
        titleLable.text = model.title
        owerviewLabel.text = model.titleOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        webWiew.load(URLRequest(url: url))
    }
    
}
