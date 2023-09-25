//
//  HomeViewController.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

//MARK: - HomeViewController
final class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(HomeTableCell.self, forCellReuseIdentifier: HomeTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureName()
        
        let headerView = HeaderView(frame: .init(origin: .zero, size: .init(width: self.view.bounds.width, height: self.view.bounds.height * 0.5)))
        tableView.tableHeaderView = headerView
        
        // Binding ViewModel / Reload Table
        viewModel.movie.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // configureName
    private func configureName() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LogoView())
    }
}

//MARK: Extension UITableViewDelegate
extension HomeViewController: UITableViewDelegate {}

//MARK: Extension UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, for: indexPath) as? HomeTableCell else {
            return UITableViewCell() }
        
        //SUBSCRIBE DELEGATE
        cell.delegate = self
        
        //MARK: - IndexPath.Section
        switch indexPath.section {
        case HomeViewModel.Sections.trendingMovies.rawValue:
            viewModel.fetchTrendingMovies { movie in
                cell.configure(movie)
            }
            
        case HomeViewModel.Sections.popular.rawValue:
            viewModel.fetchPopular { movie in
                cell.configure(movie)
            }
            
        case HomeViewModel.Sections.trendingTV.rawValue:
            viewModel.fetchTrendingTV { movie in
                cell.configure(movie)
            }
            
        case HomeViewModel.Sections.upComing.rawValue:
            viewModel.fetchUpComing { movie in
                cell.configure(movie)
            }
            
        case HomeViewModel.Sections.topRated.rawValue:
            viewModel.fetchTopRated { movie in
                cell.configure(movie)
            }
            
        default: return UITableViewCell()
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heghtForRowAt
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection
    }
    
    // Header text
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: .minimum(0, -offset))
    }
}

//MARK: - Extension Delegate Protocol
extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionbyTableCellDidTapCell(_ cell: HomeTableCell, item: Item, movie: Movie) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(item, with: movie)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
