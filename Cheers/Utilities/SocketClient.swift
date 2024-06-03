//
//  SocketClient.swift
//  cheers
//
//  Created by Dong on 2024/5/17.
//

import Foundation
import SocketIO

struct SocketClient {
    var manager: SocketManager
    var socket: SocketIOClient
    
    init (to socketURL: URL) {
        self.manager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        socket.connect()
    }
}
