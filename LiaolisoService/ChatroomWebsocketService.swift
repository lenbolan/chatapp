//
//  ChatroomWebsocketService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/19.
//

public protocol ChatroomWebsocketAPI {
    
    func login(username: String, email: String)
    
}

public class ChatroomWebsocketService {
    
    public init() {
        
    }
    
}

extension ChatroomWebsocketService: ChatroomWebsocketAPI {
    
    public func login(username: String, email: String) {
        print("Login request received for username: \(username) and email: \(email)")
    }
    
}
