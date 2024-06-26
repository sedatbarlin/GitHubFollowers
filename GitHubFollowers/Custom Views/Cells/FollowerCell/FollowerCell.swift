//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Sedat on 7.05.2024.
//


import UIKit
import SnapKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat = 8
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        if #available(iOS 16.0, *){
            contentConfiguration = UIHostingConfiguration{
                FollowerView(follower: follower)
            }
        } else{
            avatarImageView.downloadImage(fromURL: follower.avatarUrl)
            usernameLabel.text = follower.login
        }  
    }
    
    private func setupUI(){
        addSubviews(avatarImageView, usernameLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.leading.equalTo(avatarImageView.snp.leading)
            make.trailing.equalTo(avatarImageView.snp.trailing)
            make.height.equalTo(20)
        }
    }
}
