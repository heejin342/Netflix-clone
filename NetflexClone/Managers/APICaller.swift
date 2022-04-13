//
//  APICaller.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/04.
//

import Foundation

struct Constraints {
    //https://api.themoviedb.org/3/trending/all/day?api_key=8db2781cc628de60e1d359f23f467ed2
    static let API_KEY = "8db2781cc628de60e1d359f23f467ed2"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shated = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constraints.baseURL)/3/trending/all/day?api_key=\(Constraints.API_KEY)") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                
                completion(.success(result.results))
                
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        }
        
        task.resume()
    }
    
    func getTrendingTVs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constraints.baseURL)/3/trending/tv/day?api_key=\(Constraints.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))

                print(results)
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMoview(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constraints.baseURL)/3/movie/upcoming?api_key=\(Constraints.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
                
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constraints.baseURL)/3/movie/popular?api_key=\(Constraints.API_KEY)") else {return}

        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))
                print(results)
                
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constraints.baseURL)/3/movie/top_rated?api_key=\(Constraints.API_KEY)") else {return}
       
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constraints.baseURL)/3/discover/movie?api_key=\(Constraints.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else  {return}
        
        guard let url = URL(string: "\(Constraints.baseURL)/3/search/movie?api_key=\(Constraints.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendginTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
}


