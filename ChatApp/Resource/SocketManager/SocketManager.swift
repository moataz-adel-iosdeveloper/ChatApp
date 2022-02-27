//
//  SocketUber.swift
//  Golden Way
//
//  Created by moamed maya on 31/08/2021.
//  Copyright © 2021 Locus-Project. All rights reserved.
//

import Foundation
import SocketIO
import UIKit
class publicSocketManager {

    public static var `default` = publicSocketManager()
    private var manager: SocketManager = SocketManager(socketURL: URL(string:domainUrl.socketDomain)!)
    private var socket: SocketIOClient!

    private init() {
        let defaults = UserDefaults.standard
        if let user = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserModel.self, from: user) {
                manager = SocketManager(socketURL: URL(string: domainUrl.socketDomain)!, config: [.log(true),.connectParams(["query": "id= \(user.user?.id ?? 0)"])])
                socket = manager.defaultSocket
            }
        }
    }
    func connectSocket(completion: @escaping(Bool) -> () ) {
        disconnectSocket()
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Socket connected")
            //self?.socket.removeAllHandlers()
            completion(true)
        }
        socket.connect()
    }

    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("Socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false
    }

    enum Events {

        case addFriend
        
        var emitterName: String {
            switch self {
            case .addFriend:
                return "newFriend"
            }
        }

        var listnerName: String {
            switch self {
            case .addFriend:
                return "newFriend"
            }
        }

        func emit(params: [String : Any]) {
            publicSocketManager.default.socket.emit(emitterName, params)
        }

        func listen(completion: @escaping (Any) -> Void) {
            publicSocketManager.default.socket.on(listnerName) { (response, emitter) in
                completion(response)
            }
        }

        func off() {
            publicSocketManager.default.socket.off(listnerName)
        }
    }
}
