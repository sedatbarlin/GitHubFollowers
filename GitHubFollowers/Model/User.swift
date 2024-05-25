//
//  User.swift
//  GitHubFollowers
//
//  Created by Sedat on 6.05.2024.
//

import Foundation

struct User: Codable{
    var login: String
    var avatarUrl: String
    var name: String? 
    var location: String? 
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
