//
//  RefreshTokenResponse.swift
//  Models
//
//  Created by lenbo lan on 2021/1/14.
//

import Foundation

import Utility

// MARK: - RefreshTokenResponse
public struct RefreshTokenResponse: Codable {
    public let message: String
    public let tokenData: TokenData
}

// MARK: - RefreshTokenResponse convenience initializers and mutators

public extension RefreshTokenResponse {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(RefreshTokenResponse.self, from: data)
    }
    
}
