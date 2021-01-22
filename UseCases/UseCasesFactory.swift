//
//  UseCasesFactory.swift
//  UseCases
//
//  Created by lenbo lan on 2020/12/19.
//

import LiaolisoService

public final class UseCasesFactory {
    
    private static let deployedUrl = "http://www.chat.com/"
//    private static let deployedUrl = "https://lbchat.herokuapp.com/"
    private static let websocketService = ChatroomWebsocketService(socketUrl: deployedUrl)
    private static let accountService = AccountService()
    private static let userSettings = UserSettingsService.shared
    private static let chatroomsService = ChatroomsService.shared
    public static let accoutsInteractor: AccountInteractor = AccountInteractor(
        accountService: accountService,
        userSettings: userSettings,
        websocketService: websocketService)
    public static let chatroomsInteractor: ChatroomsInteractor = ChatroomsInteractor(chatroomsService: chatroomsService)
    
}
