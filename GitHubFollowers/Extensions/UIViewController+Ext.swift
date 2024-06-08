//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Sedat on 6.05.2024.
//

import UIKit
import SnapKit
import SafariServices

extension UIViewController{
    
    func presentGFAlert(title: String, message: String, buttonTitle: String, yesButtonAction: (() -> Void)? = nil) {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle, yesButtonAction: yesButtonAction)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
        }
    
    func presentDefaultError(){
        let alertVC = GFAlertVC(alertTitle: "Something Went Wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
