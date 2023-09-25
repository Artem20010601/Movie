//
//  LogoView.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

final class LogoView: UIView {

    private let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Netflix")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        addSubview(image)
      
        self.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 40),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func tap() {
        print("TAPPED")
    }
    
    

}
