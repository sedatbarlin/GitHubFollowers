//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 29.05.2024.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    var user: User!
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUIElements()
    }
    
    func configureUIElements(){
        avatarImageView.downloadImage(fromURL: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    func setupUI(){
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview()
            make.width.height.equalTo(90)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
            make.trailing.equalToSuperview()
            make.height.equalTo(38)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImageView.snp.bottom)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(textImagePadding)
            make.width.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView)
            make.leading.equalTo(locationImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(textImagePadding)
            make.leading.equalTo(avatarImageView)
            make.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
    }
}
