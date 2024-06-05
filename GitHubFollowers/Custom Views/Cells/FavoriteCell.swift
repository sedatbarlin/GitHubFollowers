//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Sedat on 31.05.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
        usernameLabel.text = favorite.login
    }
    
    public func configure(){
        let padding: CGFloat = 12
        addSubviews(avatarImageView, usernameLabel)
        accessoryType = .disclosureIndicator
        
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(padding)
            make.width.height.equalTo(60)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(40)
        }
    }
}
