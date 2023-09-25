//
//  HomeViewModel.swift
//  Spotidy
//
//  Created by Artem on 13/09/2023.
//

import Foundation

//MARK: - HomeViewModel
final class HomeViewModel {
    
    //MARK: - Section For Table into HomeVC
    enum Sections: Int {
        case trendingMovies = 0
        case popular = 1
        case trendingTV = 2
        case upComing = 3
        case topRated = 4
    }
    
    //Movie
    var movie: Observable<[Movie]> = Observable(value: [])
    
    //Sections
    let sectionTitle: [String] = ["Trending Movies", "Popular", "Trending TV", "Upcoming Movies", "Top rated"]
    
    //Properties
    var numberOfRowsInSection: Int {
        return 1
    }
    
    var heghtForRowAt: CGFloat {
        return 200
    }
    
    var heightForHeaderInSection: CGFloat {
        return 40
    }
    
    
    //MARK: - API CALLER
    
    // TrendingMovies
    public func fetchTrendingMovies(completion: @escaping ([Movie]) -> Void) {
        APICaller.shared.fetchData(url: .trandingMovies, httpHeaders: Manager.HTTPHEADERS.headers) { result in
            switch result {
            case .success(let trendingMovies):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    completion(trendingMovies.movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Popular
    public func fetchPopular(completion: @escaping ([Movie]) -> Void){
        APICaller.shared.fetchData(url: .popular, httpHeaders: Manager.HTTPHEADERS.headers) { result in
            switch result {
            case .success(let popular):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    completion(popular.movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // TrendingTV
    public func fetchTrendingTV(completion: @escaping ([Movie]) -> Void) {
        APICaller.shared.fetchData(url: .trendingTV, httpHeaders: Manager.HTTPHEADERS.headers) { result in
            switch result {
            case .success(let trendingTV):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    completion(trendingTV.movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // UpComing
    public func fetchUpComing(completion: @escaping ([Movie]) -> Void) {
        APICaller.shared.fetchData(url: .upcominMovies, httpHeaders: Manager.HTTPHEADERS.headers) { result in
            switch result {
            case .success(let upComing):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    completion(upComing.movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // TopRated
    public func fetchTopRated(completion: @escaping ([Movie]) -> Void) {
        APICaller.shared.fetchData(url: .topRated, httpHeaders: Manager.HTTPHEADERS.headers) { result in
            switch result {
            case .success(let topRated):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    completion(topRated.movie)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
 
