//
//  ChatroomsHttpRouter.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/10.
//

import Alamofire

enum ChatroomsHttpRouter {
    case chatrooms
}

extension ChatroomsHttpRouter: ReactiveHttpRouter {
    
    private var accessToken: String {
        return UserSettingsService.shared.accessToken
    }
    
    var baseUrlString: String {
        return "http://localhost/"
    }
    
    var path: String {
        switch self {
        case .chatrooms:
            return "chatrooms"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatrooms:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
    }
    
    var requestInterceptor: RequestInterceptor? {
        return JWTAccessTokenInterceptor(userSettingsService: UserSettingsService.shared)
    }
    
}
