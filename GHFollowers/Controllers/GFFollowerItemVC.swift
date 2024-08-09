//
//  GFFollowersItemVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 06/08/2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElementsData()
    }
    
    func configureUIElementsData() {
        itemInfoViewOne.setData(title: "Followers", count: user.followers, icon: Constants.heartIcon)
        itemInfoViewTwo.setData(title: "Following", count: user.following, icon: Constants.personsIcon)
        actionButton.setTitle("Get Followers", for: .normal)
        actionButton.backgroundColor = .systemGreen
    }
    
    override func actionButtonPressed(){
        delegate?.didTapGetFollowers(self, for: user)
    }
}

