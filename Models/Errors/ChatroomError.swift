//
//  ChatroomError.swift
//  Models
//
//  Created by lenbo lan on 2021/1/2.
//

public enum ChatroomError: Error {
    case notFound
    case mandatoryMissing
    case internalError
    case unauthorized
    case parsingFailed
    case custom(error: String)
}
