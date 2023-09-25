//
//  CominSoonViewModel.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import Foundation

//MARK: - CominSoonViewModel
final class ComingSoonViewModel {
    
    //Movie Observable
    var movie: Observable<[Movie]> = Observable(value: [])
    
    //API
    public func fetchUpComing() {
        APICaller.shared.fetchData(url: .upcominMovies, httpHeaders: Manager.HTTPHEADERS.headers) { (result: Result<TrendingMovie, Manager.HTTPERROR>) in
            switch result {
            case .success(let upComing):
                DispatchQueue.main.async {
                    self.movie.value = upComing.movie
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

