//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/2/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVCView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems (){
        itemInfoViewOne.set(itemIfnoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemIfnoType: .gists, count: user.publicGists)
        actionButton.set(backgroundColor: .purple, title: "GitHub Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(user: user)
    }
}
















