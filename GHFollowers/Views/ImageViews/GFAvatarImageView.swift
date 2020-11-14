//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avater_placeholder")
    let cache = NetwrokManager.shared.cache  // we do cache in networkManger as we want have one instance cahce

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }	
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure (){

        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            self?.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self?.image = image
            }
            
        }
        task.resume()
    }
    
    
    
    
    

}
