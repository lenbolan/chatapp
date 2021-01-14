//
//  RefreshToken.swift
//  Models
//
//  Created by lenbo lan on 2021/1/14.
//

import Foundation

import Utility

public struct RefreshToken: Codable {
    
    public let email: String
    public let token: String
    
    public init(email: String, token: String) {
        self.email = email
        self.token = token
    }
    
}

public extension RefreshToken {
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
}
