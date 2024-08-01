//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import Foundation

class MovieDetailViewModel {
    private let apiService: APIService
    var movieDetail: MovieDetail?
    var onMovieDetailUpdated: (() -> Void)?

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func fetchMovieDetails(imdbID: String) {
        apiService.fetchMovieDetails(imdbID: imdbID) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
                self?.onMovieDetailUpdated?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
