//
//  ComingSoonTableCell.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

//MARK: - ComingSoonTableCell
final class ComingTableCell: UITableViewCell {

    // ID
    static let identifier = "ComingSoonTableCell"
    
    // MOVIE
    public var movie: Movie? {
        didSet {
            self.title.text = movie?.name ?? "not title"
            getImageURL()
        }
    }
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .blue
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 17, weight: .semibold)
        title.numberOfLines = 0
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let play: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(play)
        setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getImageURL() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie?.posterPath ?? "not image")") else {return}
        
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
    
    @objc private func tap() {
        print("TAPPED")
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            image.widthAnchor.constraint(equalToConstant: 150),
            
            title.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: play.leadingAnchor, constant: -25),
            
            play.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            play.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            play.widthAnchor.constraint(equalToConstant: 50),
            play.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
