//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Aasem Hany on 16/07/2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = .systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        
        // Mostly used with title label
        lineBreakMode = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }
        
}
