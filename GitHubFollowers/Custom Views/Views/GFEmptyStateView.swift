//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Sedat on 28.05.2024.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }
    
    private func setupUI(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-150)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(200)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.3)
            make.height.equalTo(self.snp.width).multipliedBy(1.3)
            make.trailing.equalToSuperview().offset(170)
            make.bottom.equalToSuperview().offset(40)
        }
    }
}
