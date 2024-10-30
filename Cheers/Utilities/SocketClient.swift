//
//  SocketClient.swift
//  cheers
//
//  Created by Dong on 2024/5/17.
//

import Foundation
import SocketIO

struct SocketClientConfig {
    var logging = true
    var reconnects = true
    var reconnectAttempts = 3
}

struct SocketClient {
    var manager: SocketManager
    var socket: SocketIOClient
    
    init (
        to socketURL: URL,
        config: SocketClientConfig = SocketClientConfig()
    ) {
        guard socketURL.scheme == "ws" || socketURL.scheme == "wss"
        else { preconditionFailure("Invalid WebSocket URL schema") }
        
        self.manager = SocketManager(
            socketURL: socketURL,
            config: [
                .log(config.logging),
                .compress,
                .reconnects(config.reconnects),
                .reconnectAttempts(config.reconnectAttempts)
            ]
        )
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        socket.connect()
    }
}
