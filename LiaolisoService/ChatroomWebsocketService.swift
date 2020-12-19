//
//  ChatroomWebsocketService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/19.
//

import SocketIO

public protocol ChatroomWebsocketAPI {
    
    func login(username: String, email: String)
    
}

public class ChatroomWebsocketService {
    
    private let socketUrl: String
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    
    public init(socketUrl: String) {
        self.socketUrl = socketUrl
        setup(usingSocketUrl: URL(string: self.socketUrl)!)
    }
    
    deinit {
        self.socket.disconnect()
    }
    
}

extension ChatroomWebsocketService: ChatroomWebsocketAPI {
    
    public func login(username: String, email: String) {
        print("Login request received for username: \(username) and email: \(email)")
        self.socket.emit("login", username, email)
    }
    
}

private extension ChatroomWebsocketService {
    
    func setup(usingSocketUrl socketUrl: URL) {
        self.socketManager = SocketManager(socketURL: socketUrl)
        self.socket = self.socketManager.defaultSocket
        
        self.socket.connect()
    }
    
}
