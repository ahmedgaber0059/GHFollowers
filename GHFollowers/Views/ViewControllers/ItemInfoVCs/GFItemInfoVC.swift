//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/6/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation
import UIKit

class GFItemInfoVCView: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init (user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.09)
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() {}
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            ])
    }
}




