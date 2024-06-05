//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 31.05.2024.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject{
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class GFItemInfoVC: UIViewController { 
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
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
        configureBackgroundView()
        configureActionButton()
        setupUI()
        configureStackView()
    }
    
    func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){
        
    }
    
    private func setupUI(){
        view.addSubviews(stackView, actionButton)
        
        let padding: CGFloat = 20
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}
