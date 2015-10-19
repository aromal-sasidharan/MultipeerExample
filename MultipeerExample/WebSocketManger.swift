//
//  WebSocketManger.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/19/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation




class WebSocketManger: WebSocket,WebSocketDelegate{
    typealias DidConnectBlock = ((socket: WebSocket)->())
    typealias DidDisConnectBlock = ((socket: WebSocket,  error: NSError?)->())
    typealias DidReceiveMessageBlock = ((socket: WebSocket, text: String)->())
    typealias DidReceiveDataBlock = ((socket: WebSocket, data: NSData)->())
    
    var connectBlock : DidConnectBlock?
    var disConnectBlock : DidDisConnectBlock?
    var receiveMessageBlock : DidReceiveMessageBlock?
    var receiveDataBlock : DidReceiveDataBlock?
    
    private class var sharedManager :WebSocketManger {
        struct Singleton {
            
            static let instance = WebSocketManger()
        }
        return Singleton.instance
    }
    
    
    init(){
        
        super.init(url: NSURL(string:"ws://127.0.0.1:9300")!)
        self.delegate = self
        self.connect()
        
    }
    class func sendString(string:String) {
        WebSocketManger.sharedManager.writeString(string)
    }
    class func onSocketUpdate(connectBlock : DidConnectBlock,disConnectBlock : DidDisConnectBlock,receiveMessageBlock : DidReceiveMessageBlock,receiveDataBlock : DidReceiveDataBlock){

        WebSocketManger.sharedManager.onSocketUpdate(connectBlock, disConnectBlock: disConnectBlock, receiveMessageBlock: receiveMessageBlock, receiveDataBlock: receiveDataBlock)
    }
    private func onSocketUpdate(connectBlock : DidConnectBlock,disConnectBlock : DidDisConnectBlock,receiveMessageBlock : DidReceiveMessageBlock,receiveDataBlock : DidReceiveDataBlock){
        
        self.connectBlock = connectBlock
        
        self.disConnectBlock = disConnectBlock
        
        self.receiveDataBlock = receiveDataBlock
        
        self.receiveMessageBlock = receiveMessageBlock
    }
    func websocketDidConnect(socket: WebSocket){
        
        
        print("Websocket Connected")
        
        self.connectBlock?(socket: socket)
        
    }
    func websocketDidDisconnect(socket: WebSocket, error: NSError?){
        print("websocketDidDisconnect")
        self.disConnectBlock?(socket: socket, error: error)
    }
    func websocketDidReceiveMessage(socket: WebSocket, text: String){
        print("websocketDidReceiveMessage \(text)")
        self.receiveMessageBlock?(socket: socket, text: text)
    }
    func websocketDidReceiveData(socket: WebSocket, data: NSData){
        
        print("websocketDidReceiveData")
        
        self.receiveDataBlock?(socket: socket, data: data)
    }
    
    
}