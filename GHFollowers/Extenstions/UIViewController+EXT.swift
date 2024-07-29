//
//  UIViewController+EXT.swift
//  GHFollowers
//
//  Created by Aasem Hany on 10/05/2024.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertVCOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let gfAlertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            gfAlertVC.modalTransitionStyle = .crossDissolve
            gfAlertVC.modalPresentationStyle = .overFullScreen
            self.present(gfAlertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.0
        
        UIView.animate(withDuration: 0.25){ containerView.alpha = 0.8 }
        
        // Note that when you specified the style as large you don't need the other 2 constraints
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String) {
        let emptyStateView = GFEmptyStateView(with: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
