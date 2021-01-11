//
//  Message.swift
//  Models
//
//  Created by lenbo lan on 2021/1/10.
//

// Message.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let message = try Message(json)

import Foundation

import Utility

// MARK: - Message
public struct Message: Codable {
    public let sender, kind, status: String
    public let content: String?
    public let createdAt, updatedAt, id: String
    public let url: String?
    public let extn: String?

    enum CodingKeys: String, CodingKey {
        case sender, kind, status, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id, url, extn
    }
}

// MARK: Message convenience initializers and mutators

public extension Message {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Message.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
