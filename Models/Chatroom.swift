//
//  Chatroom.swift
//  Models
//
//  Created by lenbo lan on 2021/1/10.
//

import Foundation

import Utility

// MARK: - Chatroom
public struct Chatroom: Codable {
    public let status: Bool
    public let members: [Member]
    public let messages: [Message]
    public let creator, name, subject, createdAt: String
    public let updatedAt, id: String

    enum CodingKeys: String, CodingKey {
        case status, members, messages, creator, name, subject
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
    }
}

// MARK: Chatroom convenience initializers and mutators

public extension Chatroom {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Chatroom.self, from: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Chatroom: Equatable {
    public static func == (lhs: Chatroom, rhs: Chatroom) -> Bool {
        lhs.id == rhs.id
    }
}

extension Chatroom: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
