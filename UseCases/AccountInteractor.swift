//
//  AccountInteractor.swift
//  UseCases
//
//  Created by lenbo lan on 2020/12/19.
//

import RxSwift
import RxRelay
import LiaolisoService
import Models

public final class AccountInteractor {
    
    private let websocketService: ChatroomWebsocketAPI
    
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(websocketService: ChatroomWebsocketAPI) {
        self.websocketService = websocketService
    }
    
}

public extension AccountInteractor {
    
    func login(username: String, email: String) -> Single<()> {
//        self.websocketService.login(username: username, email: email)
        return self.websocketService.socketResponse
            .debug("Websocket login flow", trimOutput: false)
            .filter({
                guard case .loggedIn = $0 else { return false }
                return true
            })
            .map { (result) -> User? in
                guard case .loggedIn(let username, let email) = result else { return nil }
                return User(email: email, username: username)
            }
            .take(1)
            .flatMap(saveUser(user:))
            .asSingle()
            .do(onSubscribe: { [weak self] in
                self?.websocketService.login(username: username, email: email)
            })
    }
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRelay.accept(user)
        return .just(())
    }
    
}
