//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 08/07/2024.
//

import UIKit

class UserInfoVC: UIViewController {
    // MARK: - Dependencies
    let userName: String!
    let networkManager: NetworkManager
    
    // MARK: - UIElements
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    init(userName: String!, networkManager: NetworkManager) {
        self.userName = userName
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutViews()
        getUserInfo()
    }
    
    private func getUserInfo(){
        self.showLoadingView()
        networkManager.getUserInfo(for: userName){ [weak self] result in
            guard let self else{ return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(GFUserInfoHeaderVC(networkManager: self.networkManager, user: user), to: self.headerView)
                    self.add(GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormate)"
                }
            case .failure(let error):
                self.presentGFAlertVCOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
            self.dismissLoadingView()

        }
    }
    
}


// MARK: - Configure UI Elements
extension UserInfoVC{
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutViews() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            itemViewOne.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: itemViewOne.leadingAnchor),
            itemViewTwo.trailingAnchor.constraint(equalTo: itemViewOne.trailingAnchor),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalTo: itemViewTwo.widthAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func add(_ childVC: UIViewController, to view: UIView) {
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = view.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}

