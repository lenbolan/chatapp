//
//  ChatroomHttpRouter.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/22.
//

import Alamofire

import Models

enum ChatroomHttpRouter {
    case create(chatroom: Chatroom)
}

extension ChatroomHttpRouter: ReactiveHttpRouter {
    var baseUrlString: String {
        return "http://localhost/"
    }
    
    var path: String {
        switch self {
        case .create:
            return "chatroom"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let chatroom):
            return try chatroom.jsonData()
        }
    }
    
    var requestInterceptor: RequestInterceptor? {
        return JWTAccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
}
