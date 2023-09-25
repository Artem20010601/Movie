//
//  SearchResultViewModel.swift
//  Spotidy
//
//  Created by Artem on 13/09/2023.
//

import Foundation

//MARK: - SearchResultViewModel
final class SearchResultViewModel {
    
    //Movie Observable
    var movie: Observable<[Movie]> = Observable(value: [])
    
    //API
    public func fetchSearchResult(query: String) {
        APICaller.shared.fetchData(url: .searchResult(query: query), httpHeaders: Manager.HTTPHEADERS.headers) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trendingMovie):
                    self.movie.value = trendingMovie.movie
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
