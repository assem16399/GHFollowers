//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Aasem Hany on 18/05/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {

    
    
    init(){
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
        
    
}
