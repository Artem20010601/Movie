//
//  ComingSoonViewController.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

//MARK: - ComingSoonViewController
final class ComingSoonViewController: UIViewController {

    //MARK: viewModel
    private let viewModel: ComingSoonViewModel = ComingSoonViewModel()
    
    // tableUpComing
    private let tableUpComing: UITableView = {
        let table = UITableView()
        table.register(ComingTableCell.self, forCellReuseIdentifier: ComingTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableUpComing)
        
        //Delegate
        tableUpComing.delegate = self
        tableUpComing.dataSource = self
        
        
        // Binding ViewModel / Reload Table
        viewModel.movie.bind { _ in
            DispatchQueue.main.async {
                self.tableUpComing.reloadData()
            }
        }

    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableUpComing.frame = view.bounds
        
        //
        self.viewModel.fetchUpComing()
    }
}

//MARK: - Extension UITableViewDelegate
extension ComingSoonViewController: UITableViewDelegate {}

//MARK: - Extension UITableViewDataSource
extension ComingSoonViewController: UITableViewDataSource {
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
