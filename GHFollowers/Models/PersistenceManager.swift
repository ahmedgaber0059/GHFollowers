//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

enum PersitenceActionType {
    case add, remove
}

enum PeristenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith (favorite: Follower, actionType: PersitenceActionType, completed: @escaping (GFError?)->Void) {
        retrieveFavorites { (favorites, errorMessage) in
            guard let favorites = favorites else {
                completed (errorMessage)
                return
            }
            var retrievedFavorites = favorites
            
            switch actionType {
            case .add:
                let favoriteExisted =  retrievedFavorites.contains(where: { (fav) -> Bool in
                    if favorite.login == fav.login  {return true}
                    else {return false}
                })
                print(favoriteExisted)
                print(retrievedFavorites)
                
                if favoriteExisted == true {
                    completed(.alreadyInFavorites)
                }
                else{
                    retrievedFavorites.append(favorite)
                }
                
            case.remove:
                retrievedFavorites = retrievedFavorites.filter {$0.login != favorite.login}
            }
            completed(save(favorites: retrievedFavorites))
            
            
        }
    }


    static func retrieveFavorites(completed: @escaping ([Follower]? , GFError?)->Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed ([], nil)
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self , from: favoritesData)
            completed(favorites , nil)
        }
        catch {
            completed(nil , .unableToFavoirte)
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch {
            return .unableToFavoirte
        }
    }
    
}









