//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Aasem Hany on 12/05/2024.
//

import UIKit

struct NetworkManagerProvider {
    
    
    private let baseUrl = "https://api.github.com/users/"
    static let shared = NetworkManagerProvider()
    
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}

    
    func downloadImage(from url: String, completed: @escaping (UIImage?)-> Void){
        let cacheKey = NSString(string: url)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            completed(cachedImage)
            return
        }
        
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {  data, response, error in
            
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
        
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endpoint = baseUrl + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))

            } catch {
                completed(.failure(.invalidData))
            }
            
            
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        
        let endpoint = baseUrl + username
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            if error != nil {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // This decoding strategy will allow us to convert any formatted string date in the server
            //into Swift Date object, hence u won't need the String extension to convert from string to date.
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
            
            
        }
        task.resume()
    }
    
}

protocol NetworkManager {
    var cache: NSCache<NSString, UIImage> { get }
    
    func getFollowers(for username:String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void)
    
    func downloadImage(from url: String, completed: @escaping (UIImage?)-> Void)
    
    func getUserInfo(for username:String, completed: @escaping (Result<User, GFError>) -> Void)
    
}


struct NetworkManagerImpl: NetworkManager{
    func downloadImage(from url: String, completed: @escaping (UIImage?) -> Void) {
        NetworkManagerProvider.shared.downloadImage(from: url, completed: completed)
    }
    
    
    var cache: NSCache<NSString, UIImage>{ NetworkManagerProvider.shared.cache }

    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        NetworkManagerProvider.shared.getUserInfo(for: username, completed: completed)
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        NetworkManagerProvider.shared.getFollowers(for: username, page: page, completed: completed)
    }
    
}
