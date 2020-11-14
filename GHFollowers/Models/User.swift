//
//  User.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 9/7/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
    let createdAt: String
}
