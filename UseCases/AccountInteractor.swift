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
    
    private let accountService: AccountAPI
    private let userSettings: UserSettingsAPI
    
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(accountService: AccountAPI, userSettings: UserSettingsAPI) {
        self.accountService = accountService
        self.userSettings = userSettings
    }
    
}

public extension AccountInteractor {
    
    func login(email: String, password: String) -> Single<()> {
        self.accountService
            .login(email: email, password: password)
            .flatMap(saveUser(user:))
    }
    
    func signUp(email: String, username: String, password: String) -> Single<()> {
        self.accountService
            .signUp(user: User(email: email, username: username, password: password))
            .flatMap(saveUser(user:))
    }
    
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRelay.accept(user)
        if let tokenData = user?.tokenData {
            self.userSettings.saveTokens(tokenData: tokenData)
        }
        return .just(())
    }
    
}
