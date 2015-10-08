//
//  SessionManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class SessionManager:NSObject{
    
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    var session : MCSession?
    
    override init(){
        
        super.init()
        
        
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        
        session?.delegate = self
        
    }
    
    
    
    
    
    
}

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .NotConnected: return "NotConnected"
        case .Connecting: return "Connecting"
        case .Connected: return "Connected"
        default: return "Unknown"
        }
    }
}


extension SessionManager:MCSessionDelegate{
    
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        NSLog("%@","peer \(peerID) didChangeState: \(state.stringValue())")
     
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
       print("didReceiveData: \(data)")
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("didReceiveStream")
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        print("didFinishReceivingResourceWithName")
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        print("didStartReceivingResourceWithName")
    }
    
}