//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

enum GFError: String  {
    case invalidUsername = "This useraname created is invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the sever was invalid. Please try again."
    case unableToFavoirte = "There is an error favoirting this user. Please try again."
    case alreadyInFavorites = "You 've already favoruited this user. You must REALLY like him!"
}
