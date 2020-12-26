//
//  ChatroomWebsocketService.swift
//  LiaolisoService
//
//  Created by lenbo lan on 2020/12/19.
//

import SocketIO
import RxSwift
import RxRelay

import Models

public protocol ChatroomWebsocketAPI {
    
    var socketResponse: Observable<ChatroomWebsocket.Response> { get }
    func login(username: String, email: String)
    
}

public class ChatroomWebsocketService {
    
    private let socketUrl: String
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    
    private let socketResponseRelay: PublishRelay<ChatroomWebsocket.Response> = PublishRelay()
    public lazy var socketResponse: Observable<ChatroomWebsocket.Response> = self.socketResponseRelay.asObservable()
    
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
        self.socket.emit(ChatSocket.Request.login, username, email)
    }
    
}

struct ChatSocket {
    
    struct Request {
        static let login = "login"
    }
    
    struct Response {
        static let loginResponse = "loginResponse"
    }
    
}

private extension ChatroomWebsocketService {
    
    func setup(usingSocketUrl socketUrl: URL) {
        self.socketManager = SocketManager(socketURL: socketUrl)
        self.socket = self.socketManager.defaultSocket
        
        self.socket.connect()
        
        self.socket.on(ChatSocket.Response.loginResponse) { [weak self] (dataArray, socketAck) in
            print("Login successful for user: \(dataArray)")
            
            if let username = dataArray[0] as? String,
               let email = dataArray[1] as? String {
                self?.socketResponseRelay.accept(.loggedIn(username: username, email: email))
            }
        }
    }
    
}
