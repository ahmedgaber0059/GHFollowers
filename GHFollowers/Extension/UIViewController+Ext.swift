//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/4/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import UIKit

fileprivate var containView: UIView?

extension UIViewController {
    
    func presentGFAlerfOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    

    func showLoadingView () {
        containView = UIView(frame: view.bounds)
        
        if let containView = containView {
            view.addSubview(containView)
            
            containView.backgroundColor = .white
            containView.alpha = 0
            
            UIView.animate(withDuration: 0.25) {
                containView.alpha = 0.8
            }
            
            let activaityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            containView.addSubview(activaityIndicator)

            activaityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activaityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activaityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
                activaityIndicator.startAnimating()
	       }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containView?.removeFromSuperview()
            containView = nil

        }
    }
    
    
    func showEmptyStateView(message: String, view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}




