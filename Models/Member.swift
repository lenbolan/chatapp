//
//  Member.swift
//  Models
//
//  Created by lenbo lan on 2021/1/10.
//

// Member.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let member = try Member(json)

import Foundation

import Utility

// MARK: - Member
public struct Member: Codable {
    public let role: Role
    public let email, id: String
}

// MARK: Member convenience initializers and mutators

public extension Member {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Member.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
