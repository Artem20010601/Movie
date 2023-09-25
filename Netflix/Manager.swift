//
//  Manager.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import Foundation


//  https://youtube.googleapis.com/youtube/v3/search?q=Harry&key=[YOUR_API_KEY]


//MARK: - Constant
enum Constant {
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTYxZTljMWJhMGU5MjJkYzRiNDJiZThmNWM3N2RhMyIsInN1YiI6IjYzNjkzNzEyYzA0OGE5MDA3OTU4MTVmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Q6F_zfj8fAmlTKM3H7gqQHLAq3gZnFj-83RZFgPhoos"
    static let youtubeApiKey = "AIzaSyB48O0JauMVYRVpRvN-RDe7MyzaqVhQM5Y"
}

//MARK: - Manager
enum Manager {
    
    //MARK: HTTPERROR
    enum HTTPERROR: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case randomError
    }

    
    //MARK: HTTPHEADERS
    enum HTTPHEADERS {
        static let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constant.accessToken)"]
    }
     
    //MARK: EndPoint_YouTube
    enum EndPointYouTube {
        case search(query: String)
        
        var url: URL! {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "youtube.googleapis.com"
            
            switch self {
            case .search(let query):
                components.path = "/youtube/v3/search"
                components.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "key", value: Constant.youtubeApiKey)]
                return components.url
            }
        }
    }
    
    //MARK: ENDPOINT
    enum EndPoint {
        case trandingMovies
        case popular
        case trendingTV
        case upcominMovies
        case topRated
        case searchResult(query: String)
        
        var url: URL! {
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.themoviedb.org"
            
            switch self {
            case .trandingMovies:
                components.path = "/3/trending/movie/week"
                components.queryItems =
                [URLQueryItem(name: "language", value: "en-US")]
                return components.url
            case .popular:
                components.path = "/3/tv/popular"
                components.queryItems = [
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")]
                return components.url
            case .trendingTV:
                components.path = "/3/trending/tv/day"
                components.queryItems =
                [URLQueryItem(name: "language", value: "en-US")]
                return components.url
            case .upcominMovies:
                components.path = "/3/tv/on_the_air"
                components.queryItems = [
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")]
                return components.url
            case .topRated:
                components.path = "/3/tv/top_rated"
                components.queryItems = [
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")]
                return components.url
            case .searchResult(let query):
                components.path = "/3/search/movie"
                components.queryItems = [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "api_key", value: Constant.accessToken)]
                print(components.url?.absoluteString ?? "")
                return components.url
            }
        }
    }
}
