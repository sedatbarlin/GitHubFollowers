//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Sedat on 7.05.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
}