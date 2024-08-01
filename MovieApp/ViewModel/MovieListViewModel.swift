//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import Foundation

class MovieListViewModel {
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private let apiService: APIService
    var onMoviesUpdated: (() -> Void)?

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        self.movies = UserDefaultsManager.shared.loadFavorites()
    }

    func fetchMovies(query: String) {
        apiService.fetchMovies(searchTerm: query) { [weak self] result in
            switch result {
            case .success(let movies):
                // Restore favorite state
                let favoriteMovies = UserDefaultsManager.shared.loadFavorites()
                self?.movies = movies.map { movie in
                    var mutableMovie = movie
                    if favoriteMovies.contains(where: { $0.imdbID == movie.imdbID }) {
                        mutableMovie.isFavorite = true
                    }
                    return mutableMovie
                }
                self?.filteredMovies = self?.movies ?? []
                self?.onMoviesUpdated?()
            case .failure(let error):
                print(error)
            }
        }
    }

    func filterMovies(by title: String) {
        if title.isEmpty {
            filteredMovies = movies
        } else {
            let lowercasedTitle = title.lowercased()
            filteredMovies = movies.filter { $0.title.lowercased().contains(lowercasedTitle) }
        }
        onMoviesUpdated?()
    }

    func numberOfMovies() -> Int {
        return filteredMovies.count
    }

    func movie(at index: Int) -> Movie {
        return filteredMovies[index]
    }

    func toggleFavorite(for movie: Movie) {
        if let index = movies.firstIndex(where: { $0.imdbID == movie.imdbID }) {
            movies[index].isFavorite.toggle()
            // Update the filteredMovies array to reflect the changes
            if let filteredIndex = filteredMovies.firstIndex(where: { $0.imdbID == movie.imdbID }) {
                filteredMovies[filteredIndex].isFavorite = movies[index].isFavorite
            }
            UserDefaultsManager.shared.saveFavorites(movies)
            onMoviesUpdated?()
        }
    }
}
