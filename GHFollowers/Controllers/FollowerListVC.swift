//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/2/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.

protocol FollowerListVCDelegate: class {
    func didRequestFollowers (username: String)
}

import UIKit

class FollowersListVC: UIViewController {
    
    var username: String!
    var followersArray: [Follower] = []
    var filteredArray: [Follower] = []
    var searchActie = false
    var originalArray: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView : UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()

        getFollowers(username: username, page: page)
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }*/
    
    func configureViewController(){
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureCollectionView (){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func configureSearchController() {
        //let searchController = UISearchController()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Seacrh for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        //navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController  = searchController
    }

    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetwrokManager.shared.getFollowers(username: username, page: page) { [weak self] (followers, errorMessage) in
            self?.dismissLoadingView()
            guard let followers = followers else {
                self?.presentGFAlerfOnMainThread(title: "Bad stuff happened", message: errorMessage!.rawValue, buttonTitle: "OK")
                return
            }
            if followers.count < 100{
                self?.hasMoreFollowers = false
            }
            self?.followersArray.append(contentsOf: followers) //using append(contentsOf) as we  add followers array to followesArray
            
            if self?.followersArray.count == 0 {
                let message = "This user doesn't have any followers. Go follow him 😀."
                DispatchQueue.main.async {
                    self?.showEmptyStateView(message: message, view: (self?.view)!)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    

    @objc func addButtonTapped (){
        showLoadingView()
        NetwrokManager.shared.getUserInfo(username: username) { [weak self] (user, error) in
            self?.dismissLoadingView()
            guard let user = user else{
                self?.presentGFAlerfOnMainThread(title: "Something went wrong.", message: error!.rawValue, buttonTitle: "OK")
                return
            }
            let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
            
            PeristenceManager.updateWith(favorite: favorite, actionType: .add, completed: { [weak self](error) in
                guard let error = error else {
                    self?.presentGFAlerfOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉. ", buttonTitle: "Yaaah!")
                    return
                }
                self?.presentGFAlerfOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK")
            })
        }
    }
}


extension FollowersListVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActie == false{
            return followersArray.count
            
        }
        else {
            return filteredArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseID, for: indexPath) as! FollowersCell
        if searchActie == false{
            cell.set(follower: followersArray[indexPath.row])
        }
        else{
            print("filtered array active")
            cell.set(follower: filteredArray[indexPath.row])
        }
        return cell
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else{return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = searchActie ? filteredArray : followersArray
        let follower = activeArray[indexPath.item]
       
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true, completion: nil)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate{
        
    func updateSearchResults(for searchController: UISearchController) {
    
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchActie == false{
            searchActie = true
        }
        
        if (searchBar.text?.count == 0){
            searchActie = false
            collectionView.reloadData()
            return
        }
   
        guard let filter = searchBar.text , !filter.isEmpty else {return}
        filteredArray = followersArray.filter {$0.login.lowercased().contains(filter.lowercased())}
        collectionView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActie = false	
        collectionView.reloadData()
    }
}

extension FollowersListVC: FollowerListVCDelegate{
    func didRequestFollowers(username: String) {
        self.username = username
        title = username
        page = 1
        searchActie = false
        followersArray.removeAll()
        filteredArray.removeAll()
        originalArray.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.reloadData()
        getFollowers(username: username, page: page)
    }
}









