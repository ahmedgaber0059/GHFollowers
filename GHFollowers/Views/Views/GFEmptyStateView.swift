//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/13/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    
    let messageLabel = GFTitleLabel(textAligments: .center, fontSize: 35)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .lightGray
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
                messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
                messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
                messageLabel.heightAnchor.constraint(equalToConstant: 200),
                
                logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
                logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
                logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
                logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 70)
            ])
    }
}














