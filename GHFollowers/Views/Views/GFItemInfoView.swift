//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/2/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFItemInfoView: UIView {
    
    enum ItemInfoType {
        case repos, gists, followers, following
    }
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAligments: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAligments: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set (itemIfnoType: ItemInfoType, count: Int){
        switch itemIfnoType {
        case .repos:
            symbolImageView.image = UIImage(named: Constant.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(named: Constant.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(named: Constant.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(named: Constant.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}









