//
//  SessionManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity






class GhostChatSession:MCSession{
    
    class var sharedSession :GhostChatSession {
        struct Singleton {
            static let instance = GhostChatSession()
        }
        return Singleton.instance
    }

    
    
    typealias StateChangeBlock = ((session: MCSession, peerID: MCPeerID, state: MCSessionState)->())
    typealias DidReceiveDataBlock = ((session: MCSession, data: NSData, peerID: MCPeerID)->())
    typealias DidReceiveStreamBlock = ((session: MCSession, stream: NSInputStream, streamName: String, peerID: MCPeerID)->())
    typealias DidFinishReceivingResourceWithNameBlock = ((session: MCSession,  resourceName: String,  peerID: MCPeerID,  localURL: NSURL,  error: NSError?)->())
    typealias DidStartReceivingResourceWithNameBlock = ((session: MCSession,  resourceName: String,  peerID: MCPeerID,  progress: NSProgress)->())
    
    var stateChange:StateChangeBlock?
    var reciveData:DidReceiveDataBlock?
    var reciveStream:DidReceiveStreamBlock?
    var finishReceiving:DidFinishReceivingResourceWithNameBlock?
    var startReceiving:DidStartReceivingResourceWithNameBlock?
    
    
    
    
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    var session : MCSession?
    
    init(){
        
        super.init(peer: myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        self.delegate = self
        
    }
    
    
    
}

extension GhostChatSession : MCSessionDelegate{
    
    
    func onSessionUpdate(stateChange : StateChangeBlock,reciveData:DidReceiveDataBlock,reciveStream:DidReceiveStreamBlock,finishReceiving:DidFinishReceivingResourceWithNameBlock,startReceiving:DidStartReceivingResourceWithNameBlock){
        self.stateChange = stateChange
        self.reciveData = reciveData
        self.reciveStream = reciveStream
        self.finishReceiving = finishReceiving
        self.startReceiving = startReceiving
        
    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
       
        
        self.stateChange?(session : session,peerID : peerID,state : state)
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
       
        
        self.reciveData?(session : session,data : data, peerID : peerID)
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        self.reciveStream?(session:session,stream:stream,streamName:streamName,peerID:peerID)
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
       
        self.finishReceiving?(session: session, resourceName: resourceName,  peerID: peerID, localURL: localURL,  error:error)
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
       
        
        self.startReceiving?(session: session,  resourceName: resourceName,  peerID: peerID,  progress: progress)
    }
    
    
}

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .NotConnected: return "NotConnected"
        case .Connecting: return "Connecting"
        case .Connected: return "Connected"
            
        }
    }
}


