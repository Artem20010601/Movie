//
//  CollectionViewCell.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

final class CollectionbyTableCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    public var movie: Movie? {
        didSet {
            getImageURL()
        }
    }
    
    private let image: UIImageView = {
        let img =  UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = .green
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = bounds
    }
    
    private func getImageURL() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie?.backdropPath ?? "not image")") else {return}
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }
        }
    }
}


