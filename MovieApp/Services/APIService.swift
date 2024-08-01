//
//  APIservice.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import Foundation

enum APIServiceError: Error {
    case failedRequest
    case invalidData
}

class APIService {
    private let baseURL = "http://www.omdbapi.com/"
    private let apiKey = "fa54a995" // Replace with your actual API key
    
    func fetchMovies(searchTerm: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)?apikey=\(apiKey)&s=\(searchTerm)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.search))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovieDetails(imdbID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let urlString = "\(baseURL)?apikey=\(apiKey)&i=\(imdbID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
