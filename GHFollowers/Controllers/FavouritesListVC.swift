//
//  FavouritesListVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 8/24/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

class FavouritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favoritesArray: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorite()
        congifureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    
    func congifureViewController() {
        view.backgroundColor = .white
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        
          navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(pushController))
    }
    
    
    @objc  func pushController (){
        let searchVC = SearchVC()
        searchVC.title = "add"
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    func configureTableView (){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorite (){
        PeristenceManager.retrieveFavorites { [weak self](favorites, error) in
            guard let favorites = favorites else{
                self?.presentGFAlerfOnMainThread(title: "Something went wrong.", message: error!.rawValue, buttonTitle: "OK")
                return
            }
            if favorites.count == 0{
                self?.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen.", view: (self?.view)!)
            }
            else {
                self?.favoritesArray = favorites
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.view.bringSubview(toFront: (self?.tableView)!)
                }
            }
        }
    }
}


extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorites = favoritesArray[indexPath.row]
        cell.set(favorite: favorites)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritesArray[indexPath.row]
        let destVC = FollowersListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{ return }
        
        let favorite = favoritesArray[indexPath.row]
        favoritesArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PeristenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self](error) in
            guard let error = error else {return}
            self?.presentGFAlerfOnMainThread(title: "Unable to remove.", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}







