//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 30/04/2024.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView(image: UIImage(resource: .ghLogo))
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { !(usernameTextField.text?.isEmpty ?? true) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowersListVC() {
        guard isUsernameEntered else {
            presentGFAlertVCOnMainThread(title: "Username is empty", 
                                         message: "Please enter a username to lookup for",
                                         buttonTitle: "Ok")
            return
        }
        
        let followersListVc = FollowersListVC(username: usernameTextField.text, networkManager: NetworkManagerImpl())
        navigationController?.pushViewController(followersListVc, animated: true)
    }
    
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            //            callToActionButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 1),
            //            callToActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}


extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Key Pressed")
        pushFollowersListVC()
        return true
    }
    
}
