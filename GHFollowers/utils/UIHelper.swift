//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Aasem Hany on 03/06/2024.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let totalWidth = view.bounds.width
        let padding: CGFloat = 12.0
        let itemSpacing: CGFloat = 10
        let availableWidth: CGFloat = totalWidth - (padding * 2) - (itemSpacing * 2)
        let itemWidth: CGFloat = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
