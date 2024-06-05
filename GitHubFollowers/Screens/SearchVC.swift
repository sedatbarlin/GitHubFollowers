//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 3.05.2024.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    var isUsernameEntered: Bool{ return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        guard isUsernameEntered else{
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😘", buttonTitle: "OK")
            }
            return
        }
        usernameTextField.resignFirstResponder()
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func setupUI(){
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        logoImageView.image = Images.ghLogo
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(topConstraintConstant)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        usernameTextField.delegate = self
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        callToActionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(120)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
