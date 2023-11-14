//
//  HeroHeaderIUView.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 08.11.2022.
//

import UIKit

class HeroHeaderIUView: UIView {
    
    private let dawnloadButton: UIButton = {
        let  button = UIButton()
        button.setTitle("Dawnload", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button

    }()

    private let playButton: UIButton = {
         let button = UIButton()
        button.setTitle("Paly", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5

        return button
    }()
    
    private let heroImageViewe: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageViewe)
        addGradient()
        addSubview(playButton)
        addSubview(dawnloadButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let dawnloadButtonConstraint = [
            dawnloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            dawnloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            dawnloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(dawnloadButtonConstraint)
    }
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        heroImageViewe.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageViewe.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
