//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Aasem Hany on 29/07/2024.
//

import UIKit

class GFItemInfoView: UIView {
    
    let iconImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),

            
        ])
    }
    
    func setData(title: String, count: Int, icon: String) {
        titleLabel.text = title
        countLabel.text = String(count)
        iconImageView.image = UIImage(systemName: icon)
    }
    

}
