//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 06/08/2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElementsData()
    }
    
    func configureUIElementsData() {
        itemInfoViewOne.setData(title: "Public Repos", count: user.publicRepos, icon: Constants.folderIcon)
        itemInfoViewTwo.setData(title: "Public Gists", count: user.publicGists, icon: Constants.textAlignLeftIcon)
        actionButton.setTitle("Github Profile", for: .normal)
        actionButton.backgroundColor = .systemPink
    }
    
     override func actionButtonPressed(){
         delegate?.didTapGitHubProfile(self, for: user)
     }
}

