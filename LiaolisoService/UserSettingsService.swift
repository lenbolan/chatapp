//
//  UserSettingsService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2021/1/10.
//

import Foundation

import Models

public protocol UserSettingsAPI {
    var accessToken: String { get }
    var refreshToken: String { get }
    func saveTokens(tokenData: TokenData)
    func getTokens() -> TokenData
    func clearTokens()
}

public final class UserSettingsService {
    
    private let EMAIL: String = "EMAIL"
    private let ACCESS_TOKEN: String = "ACCESS_TOKEN"
    private let REFRESH_TOKEN: String = "REFRESH_TOKEN"
    private let EXPIRES_IN: String = "EXPIRES_IN"
    
    public static let shared: UserSettingsService = UserSettingsService()
    
    private init() {
        
    }
    
}

extension UserSettingsService: UserSettingsAPI {
    
    public var accessToken: String {
        return UserDefaults.standard.string(forKey: ACCESS_TOKEN) ?? ""
    }
    
    public var refreshToken: String {
        return UserDefaults.standard.string(forKey: REFRESH_TOKEN) ?? ""
    }
    
    public func saveTokens(tokenData: TokenData) {
        UserDefaults.standard.set(tokenData.email, forKey: EMAIL)
        UserDefaults.standard.set(tokenData.accessToken, forKey: ACCESS_TOKEN)
        UserDefaults.standard.set(tokenData.refreshToken, forKey: REFRESH_TOKEN)
        UserDefaults.standard.set(tokenData.expiresIn, forKey: EXPIRES_IN)
    }
    
    public func getTokens() -> TokenData {
        let email = UserDefaults.standard.string(forKey: EMAIL) ?? ""
        let accessToken = UserDefaults.standard.string(forKey: ACCESS_TOKEN) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: REFRESH_TOKEN) ?? ""
        let expiresIn = UserDefaults.standard.integer(forKey: EXPIRES_IN)
        
        return TokenData(email: email,
                         accessToken: accessToken,
                         refreshToken: refreshToken,
                         expiresIn: expiresIn)
    }
    
    public func clearTokens() {
        UserDefaults.standard.removeObject(forKey: EMAIL)
        UserDefaults.standard.removeObject(forKey: ACCESS_TOKEN)
        UserDefaults.standard.removeObject(forKey: REFRESH_TOKEN)
        UserDefaults.standard.removeObject(forKey: EXPIRES_IN)
    }
    
}
