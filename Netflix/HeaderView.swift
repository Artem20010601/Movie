//
//  HeaderView.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

final class HeaderView: UIView {

    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "Iron")
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let playButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Play", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let downloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Download", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        setConstraint()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradient)
        gradient.frame = bounds
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}
