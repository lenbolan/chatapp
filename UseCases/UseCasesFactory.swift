//
//  UseCasesFactory.swift
//  UseCases
//
//  Created by lenbo lan on 2020/12/19.
//

import LiaolisoService

public final class UseCasesFactory {
    
    private static let deployedUrl = ""
    private static let websocketService = ChatroomWebsocketService(socketUrl: deployedUrl)
    public static let accoutsInteractor: AccountInteractor = AccountInteractor(websocketService: websocketService)
    
}
