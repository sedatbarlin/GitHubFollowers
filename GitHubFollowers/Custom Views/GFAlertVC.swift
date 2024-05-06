//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 6.05.2024.
//

import UIKit
import SnapKit

class GFAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "OK")
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        setupUI()
    }

    func setupUI(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(220)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong!"
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.height.equalTo(28)
        }
        
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).inset(padding)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.height.equalTo(44)
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complate request"
        messageLabel.numberOfLines = 4
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(containerView.snp.leading).offset(padding)
            make.trailing.equalTo(containerView.snp.trailing).inset(padding)
            make.bottom.equalTo(actionButton.snp.top).inset(12)
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}