//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 6.05.2024.
//

import UIKit
import SnapKit

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(color: .systemPurple, title: "OK", systemImageName: "nosign")
    let yesButton = GFButton(color: .systemGreen, title: "Yes", systemImageName: "checkmark.circle")
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var yesButtonAction: (() -> Void)?
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String, yesButtonAction: (() -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
        self.yesButtonAction = yesButtonAction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        if yesButtonAction != nil {
            view.addSubview(yesButton)
        }
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(240)
        }
        
        titleLabel.text = alertTitle ?? "Something went wrong!"
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.height.equalTo(28)
        }
        
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.bottom.equalTo(actionButton.snp.top).inset(12)
        }
        
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).inset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.height.equalTo(44)
        }
        
        if yesButtonAction != nil {
            yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
            yesButton.snp.makeConstraints { make in
                make.bottom.equalTo(containerView.snp.bottom).inset(padding)
                make.leading.equalTo(containerView.snp.leading).offset(padding)
                make.trailing.equalTo(containerView.snp.trailing).inset(padding)
                make.height.equalTo(44)
            }
            
            actionButton.snp.remakeConstraints { make in
                make.bottom.equalTo(yesButton.snp.top).offset(-10)
                make.leading.equalTo(containerView.snp.leading).offset(padding)
                make.trailing.equalTo(containerView.snp.trailing).inset(padding)
                make.height.equalTo(44)
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func yesButtonTapped() {
        dismiss(animated: true) {
            self.yesButtonAction?()
        }
    }
}
