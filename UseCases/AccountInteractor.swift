//
//  AccountInteractor.swift
//  UseCases
//
//  Created by lenbo lan on 2020/12/19.
//

import RxSwift
import LiaolisoService

public final class AccountInteractor {
    
    private let websocketService: ChatroomWebsocketAPI
    
    init(websocketService: ChatroomWebsocketAPI) {
        self.websocketService = websocketService
    }
    
}

public extension AccountInteractor {
    
    func login(username: String, email: String) -> Single<()> {
        self.websocketService.login(username: username, email: email)
        return .never()
    }
}
