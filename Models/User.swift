//
//  User.swift
//  Models
//
//  Created by lenbo lan on 2020/12/19.
//

public struct User {
    
    init(email: String, username: String) {
        self.email = email
        self.username = username
    }
    
    public let email: String
    public let username: String
    
}

