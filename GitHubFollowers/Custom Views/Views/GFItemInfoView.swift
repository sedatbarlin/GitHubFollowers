//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Sedat on 29.05.2024.
//

import UIKit

enum ItemInfoType{
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(symbolImageView)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(18)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolImageView.snp.bottom).offset(4)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(18)
        }
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int){
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
