//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/1/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView (frame: .zero)
    let username = GFTitleLabel (textAligments: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView  = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel (textAligments: .left)
    
    var user: User!
    
    init (user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements(){
        avatarImageView.downloadImage(urlString: user.avatarUrl)
        username.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "NO Loction"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = UIImage(named: Constant.loction)
        
        locationImageView.tintColor = .gray
    }
    
    
    func addSubView(){
        view.addSubview(avatarImageView)
        view.addSubview(username)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    
    func layoutUI(){
        let padding:CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            username.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            username.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            username.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor , constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
