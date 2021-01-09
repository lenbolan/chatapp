//
//  ChatroomError.swift
//  Models
//
//  Created by lenbo lan on 2021/1/2.
//

public enum ChatroomError: Error {
    case notFound(message: String)
    case mandatoryMissing
    case internalError
    case unauthorized(message: String)
    case parsingFailed
    case custom(error: String)
}

public extension ChatroomError {
    
    var errorDescription: String? {
        switch self {
        case .notFound(let message): return "\(message) not found"
        case .mandatoryMissing: return "Mandatory paramters missing"
        case .internalError: return "Something went wrong"
        case .unauthorized(let message): return "\(message) not authorized"
        case .parsingFailed: return "Something went wrong while parsing"
        case .custom(let description): return description
        }
    }
    
}
