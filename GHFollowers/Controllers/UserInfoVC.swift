//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/1/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    let dateLabel = GFBodyLabel(textAligments: .center)
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    
    func configureViewController(){
        view.backgroundColor = .white
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetwrokManager.shared.getUserInfo(username: username) { [weak self](user, error) in
            guard let user = user else{
                self?.presentGFAlerfOnMainThread(title: "Something went wrong.", message: error!.rawValue, buttonTitle: "OK")
                return
            }
            DispatchQueue.main.async { self?.configureUIElements(user: user) }
        }
    }
    
    
    func configureUIElements (user: User){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFolloweItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, containerView: self.itemViewOne)
        self.add(childVC: followerItemVC, containerView: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), containerView: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.ConvertToDisplayFormat())"
    }
    
    
    func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo]
        let padding: CGFloat = 20
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding )
            ])
        }
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func add(childVC: UIViewController, containerView: UIView){
        addChildViewController(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParentViewController: self)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlerfOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        let safariVC = SFSafariViewController (url: url)
        safariVC.preferredControlTintColor = .green
        present(safariVC, animated: true, completion: nil)
    }
    
    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            presentGFAlerfOnMainThread(title: "No followers found", message: "This user has no followrs, Go follow him 😀.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(username: user.login)
        dismissVC()
    }
    
    

    
    
}




