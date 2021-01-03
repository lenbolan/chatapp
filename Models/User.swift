// User.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try User(json)

import Foundation
import Utility

// MARK: - User
public struct User: Codable {
    public let email: String
    public var username, password: String?
    public var tokenData: TokenData?
}

// MARK: User convenience initializers and mutators

public extension User {
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
