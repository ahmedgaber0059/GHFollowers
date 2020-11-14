//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/2/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFFolloweItemVC: GFItemInfoVCView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems (){
        itemInfoViewOne.set(itemIfnoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemIfnoType: .following, count: user.following)
        actionButton.set(backgroundColor: .green, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
}

