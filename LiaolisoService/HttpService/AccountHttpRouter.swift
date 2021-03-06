//
//  AccountHttpRouter.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/1.
//

import Alamofire
import Models

public enum AccountHttpRouter {
    case login(user: User)
    case signUp(user: User)
    case refreshToken(token: RefreshToken)
}

extension AccountHttpRouter: ReactiveHttpRouter {
    
    public var baseUrlString: String {
        return "http://localhost/"
    }
    
    public var path: String {
        switch self {
        case .login:
            return "login"
        case .signUp:
            return "signup"
        case .refreshToken:
            return "token/refresh"
        }
    }
    
    public var method: HTTPMethod {
        return .post
    }
    
    public var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    public func body() throws -> Data? {
        switch self {
        case .login(let user):
            return try? user.jsonData()
        case .signUp(let user):
            return try? user.jsonData()
        case .refreshToken(let token):
            return try? token.jsonData()
        }
    }
    
}
