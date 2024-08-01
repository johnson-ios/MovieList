//
//  UserDefaultsManager.swift
//  MovieApp
//
//  Created by jaya kumar on 01/08/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let favoritesKey = "favorites"
    
    private init() {}
    
    func saveFavorites(_ movies: [Movie]) {
        let favoriteMovies = movies.filter { $0.isFavorite }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteMovies) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    func loadFavorites() -> [Movie] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Movie].self, from: data) {
                return decoded
            }
        }
        return []
    }
}
