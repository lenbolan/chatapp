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
    
    let localUrl = "http://localhost/"
    
    private let bag = DisposeBag()
    
    private let accountService: AccountAPI
    private let userSettings: UserSettingsAPI
    private let websocketService: AccountWebsocketAPI
    
    private let userRelay: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    public lazy var user: Observable<User?> = self.userRelay.asObservable()
    
    init(accountService: AccountAPI,
         userSettings: UserSettingsAPI,
         websocketService: AccountWebsocketAPI) {
        self.accountService = accountService
        self.userSettings = userSettings
        self.websocketService = websocketService
        setupSocketConnection()
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
    
    func logout() -> Single<()> {
        return Single.create { (single) -> Disposable in
            self.userSettings.clearTokens()
            single(.success(()))
            return Disposables.create()
        }
    }
    
    func validate() -> Single<Bool> {
        return Single.create { (single) -> Disposable in
            single(.success(!self.userSettings.accessToken.isEmpty))
            return Disposables.create()
        }
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
    
    func setupSocketConnection() {
        self.userSettings.tokenObservable
            .filter({ !$0.isEmpty })
            .withLatestFrom(Observable.just(localUrl)) { (URL(string: $1)!, $0) }
            .flatMap({ [websocketService] (url, token) in
                websocketService.setupConnection(usingSocketUrl: url, authToken: token)
            })
            .debug("setupConnection >>>", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
    }
    
}
