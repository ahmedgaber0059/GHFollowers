//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/2/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure (){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        
        textColor = .black
        tintColor = .black
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2) //dyaminc type
        minimumFontSize = 12
        
        backgroundColor = .white
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a username"
        
    }
    
}

