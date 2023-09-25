//
//  TableCellCollection.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

//MARK: - Protocol Delegate
protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionbyTableCellDidTapCell(_ cell: HomeTableCell, item: Item, movie: Movie)
}

//MARK: - HomeTableCell
final class HomeTableCell: UITableViewCell {

    // ID
    static let identifier = "TableCellCollection"
    
    // Weak var
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    // ViewModel
    private let viewModel = HomeCellViewModel()
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(CollectionbyTableCell.self, forCellWithReuseIdentifier: CollectionbyTableCell.identifier)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
        
        // Binding ViewModel / Reload Table
        viewModel.movie.bind { _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.collection.reloadData()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ movie: [Movie]) {
        self.viewModel.movie.value = movie
    }
}

extension HomeTableCell: UICollectionViewDelegate {}

extension HomeTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movie.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionbyTableCell.identifier, for: indexPath) as? CollectionbyTableCell else {return UICollectionViewCell()}
        cell.movie = viewModel.movie.value[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = viewModel.movie.value[indexPath.row].name ?? "no name"
        
        APICaller.shared.fetchYoutube(url: .search(query: title + " trailer")) { result in
            switch result {
            case .success(let success):
               
                let movie = self.viewModel.movie.value[indexPath.row]
                
                if let item = success.items?[indexPath.row] {
                    self.delegate?.collectionbyTableCellDidTapCell(self, item: item, movie: movie)
                    print("Item: \(item)")
                }
              
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

