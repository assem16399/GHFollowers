//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Aasem Hany on 29/06/2024.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let decorationImage = UIImageView(image: .emptyStateLogo)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(with message: String) {
        messageLabel.text = message
        super.init(frame: .zero)
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(decorationImage)
        
        messageLabel.numberOfLines = 2
        messageLabel.textColor = .secondaryLabel
        
        // we will not set tAMIC to false here as we already set it in the configure method of GFTitleLabel
        //messageLabel.translatesAutoresizingMaskIntoConstraints = false
        decorationImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            
            // we're setting height & width equal to the view width as we want them to be the same (square)
            decorationImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            decorationImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            
            // Note that we used positive constant and not negative as we used to with trailing & bottom anchors as we wanna the image to pass the our screen trailing and bottom edges
            decorationImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            decorationImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
            
            
        ])
        
    }
    
}
