//
//  Follower.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-23.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
