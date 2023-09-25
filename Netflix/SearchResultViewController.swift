//
//  SearchResultViewController.swift
//  Spotidy
//
//  Created by Artem on 13/09/2023.
//

import UIKit

final class SearchResultViewController: UIViewController {

    public var viewModel = SearchResultViewModel()
    
    public let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 9
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(CollectionbyTableCell.self, forCellWithReuseIdentifier: CollectionbyTableCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        view.addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
        
        viewModel.movie.bind { _ in
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collection.frame = view.bounds
    }
}

extension SearchResultViewController: UICollectionViewDelegate {}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movie.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionbyTableCell.identifier, for: indexPath) as? CollectionbyTableCell else {return UICollectionViewCell()}
        cell.movie = viewModel.movie.value[indexPath.row]
        return cell
    }
}

