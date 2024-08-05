//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 02/08/2024.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    // MARK: - UI Elements
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    let user: User!

    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        configureBackgroundView()
        configureStackView()
        configureActionButton()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18.0
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView(){
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        configureStackViewItems()
    }
    
    private func configureStackViewItems(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        // minimum spacing between each element
        //stackView.spacing = 100
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
        
    
    private func configureActionButton(){
        view.addSubview(actionButton)
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    

}
