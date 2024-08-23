//
//  UIViewController+EXT.swift
//  GHFollowers
//
//  Created by Aasem Hany on 10/05/2024.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGFAlertVCOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let gfAlertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            gfAlertVC.modalTransitionStyle = .crossDissolve
            gfAlertVC.modalPresentationStyle = .overFullScreen
            self.present(gfAlertVC, animated: true)
        }
    }
    
   
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
