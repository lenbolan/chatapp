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
    
}

public final class AccountService {
    
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    public init() {}
    
}

extension AccountService: AccountAPI {
    
    public func login(email: String, password: String) -> Single<User> {
        try! AccountHttpRouter
            .login(user: User(email: email, password: password))
            .rx.request(withService: httpService)
            .responseJSON()
            .map { (result) -> AuthResponse in
                guard let data = result.data else {
                    throw ChatroomError.notFound
                }
                
                if result.response?.statusCode == 200 {
                    let authResponse = try AuthResponse(data: data)
                    return authResponse
                } else {
                    throw ChatroomError.internalError
                }
            }
            .map( { $0.user } )
            .asSingle()
    }
    
}
