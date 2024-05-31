//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 29.05.2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject{
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupUI()
        getUserInfo()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User){
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func setupUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(padding)
                make.trailing.equalToSuperview().inset(padding)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(itemHeight + 40)
        }
        
        itemViewOne.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(padding)
            make.height.equalTo(itemHeight)
        }
        
        itemViewTwo.snp.makeConstraints { make in
            make.top.equalTo(itemViewOne.snp.bottom).offset(padding)
            make.height.equalTo(itemHeight)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(itemViewTwo.snp.bottom).offset(padding)
            make.height.equalTo(18)
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate{
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 😢", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
