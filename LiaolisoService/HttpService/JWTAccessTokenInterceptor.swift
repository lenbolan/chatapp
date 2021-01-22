//
//  JWTAccessTokenInterceptor.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/14.
//

import Alamofire

import Models

final class JWTAccessTokenInterceptor: RequestInterceptor {
    
    private var isRefreshing = false
    private let userSettingsService: UserSettingsAPI
    private let httpService: ChatroomHttpService = ChatroomHttpService.shared
    
    let lock = NSLock()
    
    private var accessToken: String? {
        return userSettingsService.accessToken
    }
    
    private var refreshToken: String? {
        return userSettingsService.refreshToken
    }
    
    init(userSettingsService: UserSettingsAPI) {
        self.userSettingsService = userSettingsService
    }
    
}

extension JWTAccessTokenInterceptor {
    
    /// Set the bearer token as part of header with adapt
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        lock.lock(); defer { lock.unlock() }
        
        var request = urlRequest
        
        if let token = accessToken {
            request.headers.update(.authorization(bearerToken: token))
        }
        completion(.success(request))
    }
    
}

extension JWTAccessTokenInterceptor {
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        
        lock.lock(); defer { lock.unlock() }
        
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case 401:
            guard !isRefreshing else { return }
            refreshTokens { [userSettingsService] tokenData in
                if let tokenData = tokenData {
                    userSettingsService.saveTokens(tokenData: tokenData)
                }
                completion(.retry)
            }
        default:
            completion(.doNotRetry)
        }
        
    }
    
}

extension JWTAccessTokenInterceptor {
    
    private typealias RefreshCompletion = (_ tokenData: TokenData?) -> Void
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        
        self.isRefreshing = true
        let tokenData = userSettingsService.getTokens()
        let refreshTokenData = RefreshToken(email: tokenData.email, token: tokenData.refreshToken)
        
        do {
            try AccountHttpRouter
                .refreshToken(token: refreshTokenData)
                .request(usingHttpService: self.httpService)
                .responseJSON{ [weak self, parseRefreshToken] dataResponse in
                    self?.isRefreshing = false
                    completion(parseRefreshToken(dataResponse)?.tokenData)
                }
        } catch {
            completion(nil)
        }
    }
    
    private func parseRefreshToken(responseData: AFDataResponse<Any>) -> RefreshTokenResponse? {
        
        if let error = responseData.error {
            print(error)
            return nil
        }
        
        guard let statusCode = responseData.response?.statusCode, statusCode == 200,
              let data = responseData.data else {
            return nil
        }
        
        do { return try RefreshTokenResponse.init(data: data) }
        catch { return nil }
    }
    
}
