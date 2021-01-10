//
//  AccountService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/2.
//

import Foundation
import RxSwift

import Models

public protocol AccountAPI {
    
    func login(email: String, password: String) -> Single<User>
    func signUp(user: User) -> Single<User>
    
}

public final class AccountService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    public init() {}
    
}

extension AccountService: AccountAPI {
    
    public func login(email: String, password: String) -> Single<User> {
        return AccountHttpRouter
            .login(user: User(email: email, password: password))
            .rx.request(withService: httpService)
            .responseJSON()
            .map { (result) -> AuthResponse in
                guard let data = result.data else {
                    throw ChatroomError.notFound(message: email)
                }
                if result.response?.statusCode == 200 {
                    do {
                        return try AuthResponse(data: data)
                    } catch {
                        throw ChatroomError.parsingFailed
                    }
                } else {
                    throw ChatroomError.unauthorized(message: email)
                }
            }
            .map( { $0.user } )
            .asSingle()
    }
    
    public func signUp(user: User) -> Single<User> {
        return AccountHttpRouter.signUp(user: user).rx
            .request(withService: httpService)
            .responseJSON()
            .map({ (dataResult) -> AuthResponse in
                guard let data = dataResult.data else {
                    throw ChatroomError.notFound(message: user.email)
                }
                if dataResult.response?.statusCode == 201 {
                    do {
                        return try AuthResponse(data: data)
                    } catch {
                        throw ChatroomError.parsingFailed
                    }
                } else {
                    throw ChatroomError.unauthorized(message: user.email)
                }
            })
            .map({ $0.user })
            .asSingle()
    }
    
}
