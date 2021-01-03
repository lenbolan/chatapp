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
    
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(accountService: AccountAPI) {
        self.accountService = accountService
    }
    
}

public extension AccountInteractor {
    
    func login(email: String, password: String) -> Single<()> {
        self.accountService
            .login(email: email, password: password)
            .flatMap(saveUser(user:))
    }
    
}

private extension AccountInteractor {
    
    func saveUser(user: User?) -> Single<()> {
        self.userRelay.accept(user)
        return .just(())
    }
    
}
