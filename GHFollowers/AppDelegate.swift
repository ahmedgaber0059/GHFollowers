//
//  AppDelegate.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 8/24/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow (frame: UIScreen.main.bounds)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        configureNatvigationBar()
        return true
    }
    
    
    func createSearchNC() -> UINavigationController {		
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavouriteNC() -> UINavigationController {
        let favouritesVC = FavouritesListVC()
        favouritesVC.title = "Favourite"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
 	
        return UINavigationController(rootViewController: favouritesVC)
    }
    
    
    func createTabBar () ->UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .green
        tabBar.viewControllers = [createSearchNC() , createFavouriteNC()]
        
        return tabBar
    }
    
    func configureNatvigationBar(){
        UINavigationBar.appearance().tintColor = .green
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

