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
    public var status: Bool = false
    public var members: [Member]
    public var messages: [Message] = []
    public let creator, name, subject: String
    public var createdAt, updatedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case status, members, messages, creator, name, subject
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
    }
}

// MARK: Chatroom convenience initializers and mutators

public extension Chatroom {
    
    init(name: String, subject: String, creator: String, members: [Member] = []) {
        self.name = name
        self.subject = subject
        self.creator = creator
        self.members = members
    }
    
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
