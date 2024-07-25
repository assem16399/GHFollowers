//
//  File.swift
//  GHFollowers
//
//  Created by Aasem Hany on 12/05/2024.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}

