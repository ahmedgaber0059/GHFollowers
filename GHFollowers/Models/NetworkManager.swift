//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

 class NetwrokManager {
    static let shared = NetwrokManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    private init () {}
    
    func getFollowers (username: String, page: Int, completed: @escaping ([Follower]? , GFError?)->Void){
        
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil , .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil , .unableToComplete)
            }				
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil , .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil , .invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self , from: data)
                completed(followers , nil)
            }
            catch{
                completed(nil , .invalidData)
            }
            
        }
        
        task.resume()
    }
    
    func getUserInfo (username: String, completed: @escaping (User? , GFError?)->Void){
        
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil , .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil , .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil , .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil , .invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self , from: data)
                completed(user , nil)
            }
            catch{
                completed(nil , .invalidData)
            }
            
        }
        
        task.resume()
    }
    
    
    
}
