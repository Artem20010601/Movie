//
//  TabBarViewController.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .label
        
        setViewControllers(
            [setTabBar(HomeViewController(), .home, with: .home),
             setTabBar(ComingSoonViewController(), .coming, with: .comingSoon),
             setTabBar(SearchViewController(), .search, with: .search),
             setTabBar(DownloadsViewController(), .downloads, with: .downloads)], animated: true)
    }
    
    private func setTabBar(_ vc: UIViewController, _ title: String, with mode: ModeTabBar) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers.first?.title = title
        navigationController.tabBarItem = modifierTabBarItem(mode: mode)
        return navigationController
    }
    
    
    enum ModeTabBar {
        case home
        case comingSoon
        case search
        case downloads
    }
    
    private func modifierTabBarItem(mode: ModeTabBar) -> UITabBarItem {
        switch mode {
        case .home:
            return customTabBar(name: .home, image: .homeImage)
        case .comingSoon:
            return customTabBar(name: .coming, image: .comingImage)
        case .search:
            return customTabBar(name: .search, image: .searchImage)
        case .downloads:
            return customTabBar(name: .downloads, image: .downloadsImage)
        }
    }
    
    private func customTabBar(name: String, image: String) -> UITabBarItem {
        let tabBar = UITabBarItem(title: name, image: UIImage(systemName: image), tag: 0)
        return tabBar
    }

}

extension String {
    
    //MARK: Name TabBarItem
    static let home = "Home"
    static let coming = "Coming Soon"
    static let search = "Top Search"
    static let downloads = "Downloads"
    
    //MARK: Image TabBarItem
    static let homeImage = "house"
    static let comingImage = "play.circle"
    static let searchImage = "magnifyingglass"
    static let downloadsImage = "arrow.down.to.line"

}

