//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Aasem Hany on 18/05/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {

    
    let cache: NSCache<NSString, UIImage>!
    
    init(networkManager: NetworkManager) {
        self.cache = networkManager.cache
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        // to make the image itself clipped and gets a border radius
        clipsToBounds = true
        image = UIImage(resource: .avatarPlaceholder)
    }
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            image = cachedImage
            print("getting cached Image")
            return
        }
        
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]  data, response, error in
            guard let self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
        
    }
    
    
}
