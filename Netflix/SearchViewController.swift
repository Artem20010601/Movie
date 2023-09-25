//
//  SearchViewController.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

//MARK: - SearchViewController
final class SearchViewController: UIViewController {

    //MARK: viewModel
    private let viewModel: ComingSoonViewModel = ComingSoonViewModel() // The same viewModel as the ComingSoonViewController
    
    // tableUpComing
    private let tableUpComing: UITableView = {
        let table = UITableView()
        table.register(ComingTableCell.self, forCellReuseIdentifier: ComingTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search the movie or TV-show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableUpComing)
        
        //Delegate
        tableUpComing.delegate = self
        tableUpComing.dataSource = self
        
        //SeacrhBar
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        // Binding ViewModel / Reload Table
        viewModel.movie.bind { _ in
            DispatchQueue.main.async {
                self.tableUpComing.reloadData()
            }
        }
        
        self.searchController.searchResultsUpdater = self

    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableUpComing.frame = view.bounds
        
        // API CALLER
        self.viewModel.fetchUpComing()
    }
}

//MARK: - Extension UITableViewDelegate
extension SearchViewController: UITableViewDelegate {}

//MARK: - Extension UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movie.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComingTableCell.identifier, for: indexPath) as? ComingTableCell else {return UITableViewCell()}
        
        
        cell.movie = viewModel.movie.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - Extension UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController
        else {
            print("MY ERROR!")
            return}
        
        DispatchQueue.main.async {
            resultController.viewModel.fetchSearchResult(query: query)
        }
    }
    
    
}
