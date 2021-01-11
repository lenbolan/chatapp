//
//  Role.swift
//  Models
//
//  Created by lenbo lan on 2021/1/10.
//

// Role.swift

import Foundation

public enum Role: String, Codable {
    case participant = "PARTICIPANT"
    case owner = "OWNER"
    case guest = "GUEST"
}
