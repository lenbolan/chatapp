// AuthResponse.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authResponse = try AuthResponse(json)

import Foundation
import Utility

// MARK: - AuthResponse
public struct AuthResponse: Codable {
    public let message: String
    public let user: User
}

// MARK: AuthResponse convenience initializers and mutators

public extension AuthResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AuthResponse.self, from: data)
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

    func with(
        message: String? = nil,
        user: User? = nil
    ) -> AuthResponse {
        return AuthResponse(
            message: message ?? self.message,
            user: user ?? self.user
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



// TokenData.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tokenData = try TokenData(json)

import Foundation

// MARK: - TokenData
public struct TokenData: Codable {
    let email, accessToken, refreshToken: String
    let expiresIn: Int
}

// MARK: TokenData convenience initializers and mutators

public extension TokenData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TokenData.self, from: data)
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

    func with(
        email: String? = nil,
        accessToken: String? = nil,
        refreshToken: String? = nil,
        expiresIn: Int? = nil
    ) -> TokenData {
        return TokenData(
            email: email ?? self.email,
            accessToken: accessToken ?? self.accessToken,
            refreshToken: refreshToken ?? self.refreshToken,
            expiresIn: expiresIn ?? self.expiresIn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
