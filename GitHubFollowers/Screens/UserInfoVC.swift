//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 29.05.2024.
//

import UIKit
import SnapKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        setupUI()
        getUserInfo()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    func getUserInfo(){
        Task{
            do{
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch{
                if let gfError = error as? GFError{
                    presentGFAlert(title: "Something Went Wrong", message: gfError.rawValue, buttonTitle: "Ok")
                } else{
                    presentDefaultError()
                }
            }
        }
    }
    
    func configureUIElements(with user: User){
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func setupUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews{
            contentView.addSubview(itemView)
            itemView.snp.makeConstraints { make in
                make.leading.equalTo(contentView).offset(padding)
                make.trailing.equalTo(contentView).inset(padding)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(itemHeight + 70)
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
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
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

extension UserInfoVC: GFRepoItemVCDelegate{
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlert(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate{
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else{
            presentGFAlert(title: "No followers", message: "This user has no followers. What a shame 😢", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
