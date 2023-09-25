//
//  APICaller.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    func fetchData(url: Manager.EndPoint, httpHeaders: [String: String], completion: @escaping (Result<TrendingMovie, Manager.HTTPERROR>) -> Void) {
        guard let url = URL(string: url.url.absoluteString) else {return}
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = httpHeaders
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {print(error?.localizedDescription); return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else
            { completion(.failure(.invalidResponse)); return}
            
            guard let data else { completion(.failure(.invalidData)); return}
            
            do {
                let movie = try JSONDecoder().decode(TrendingMovie.self, from: data)
                completion(.success(movie))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchYoutube(url: Manager.EndPointYouTube, completion: @escaping (Result<Youtube, Manager.HTTPERROR>) -> Void) {
        guard let url = URL(string: url.url.absoluteString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {print(error?.localizedDescription); return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else
            { completion(.failure(.invalidResponse)); return}
            
            guard let data else { completion(.failure(.invalidData)); return}
            
            do {
                let movie = try JSONDecoder().decode(Youtube.self, from: data)
                completion(.success(movie))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
