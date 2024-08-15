//
//  UserDefaultsManager.swift
//  GHFollowers
//
//  Created by Aasem Hany on 11/08/2024.
//

import Foundation


enum UserDefaultsManger{
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    static func updateFavoritesAfterAdding(_ follower: Follower, completed: @escaping (GFError?)-> Void ){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                tryToAdd(follower, to: favorites, completed: completed)
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static private func tryToAdd(_ follower: Follower, to favorites: [Follower], completed: @escaping (GFError?)-> Void ){
        guard !favorites.contains(follower) else {
            completed(.alreadyInFavorites)
            return
        }
        var updatedFavorites = favorites
        updatedFavorites.append(follower)
        completed(save(favorites: updatedFavorites))
    }
    
    static func updateFavoritesAfterRemoving(_ follower: Follower, completed: @escaping (GFError?)-> Void ){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                tryToRemove(follower, from: favorites, completed: completed)
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static private func tryToRemove(_ follower: Follower, from favorites: [Follower], completed: @escaping (GFError?)-> Void ){
        var updatedFavorites = favorites
        updatedFavorites.removeAll { favorite in favorite.login == follower.login}
        completed(save(favorites: updatedFavorites))
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>)-> Void ){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(decodedFavorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites:[Follower])-> GFError?  {
        do {
            let encoder = JSONEncoder()
            try defaults.setValue(encoder.encode(favorites), forKey: Keys.favorites)
            return nil
        }catch{
            return GFError.unableToFavorite
        }
    }
    
}
