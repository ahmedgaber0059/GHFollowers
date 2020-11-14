//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/12/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

struct UIHelper {

 static func createThreeColumnFlowLayout(view: UIView)->UICollectionViewFlowLayout {
    
    let width = view.bounds.width
    let padding: CGFloat = 10
    let minItemSpeacing: CGFloat = 12
    let avaliableWidth = width - (padding * 2) - (minItemSpeacing * 2)
    let itemWidth = avaliableWidth / 3
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    
    		
    
    return flowLayout
}
}
