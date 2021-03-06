//
//  SessionManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class GhostSession:MCSession{
    
    typealias StateChangeBlock = ((session: MCSession, peerID: MCPeerID, state: MCSessionState)->())
    typealias DidReceiveDataBlock = ((session: MCSession, data: NSData, peerID: MCPeerID)->())
    typealias DidReceiveStreamBlock = ((session: MCSession, stream: NSInputStream, streamName: String, peerID: MCPeerID)->())
    typealias DidFinishReceivingResourceWithNameBlock = ((session: MCSession,  resourceName: String,  peerID: MCPeerID,  localURL: NSURL,  error: NSError?)->())
    typealias DidStartReceivingResourceWithNameBlock = ((session: MCSession,  resourceName: String,  peerID: MCPeerID,  progress: NSProgress)->())
    typealias ReceivedCertificate = ((session: MCSession, certificate: [AnyObject]?,  peerID: MCPeerID, certificateHandler: (Bool) -> Void)->())
    
    var stateChange:StateChangeBlock?
    var reciveData:DidReceiveDataBlock?
    var reciveStream:DidReceiveStreamBlock?
    var finishReceiving:DidFinishReceivingResourceWithNameBlock?
    var startReceiving:DidStartReceivingResourceWithNameBlock?
    var certificateReceived:ReceivedCertificate?
    
    
    override init(peer: MCPeerID, securityIdentity: [AnyObject]?, encryptionPreference: MCEncryptionPreference){
        
        
        super.init(peer: peer, securityIdentity: securityIdentity, encryptionPreference: encryptionPreference)
        
        self.delegate = self
    }
    
    
    
}

extension GhostSession : MCSessionDelegate{
    
    
    func onSessionUpdate(stateChange : StateChangeBlock,reciveData:DidReceiveDataBlock,reciveStream:DidReceiveStreamBlock,finishReceiving:DidFinishReceivingResourceWithNameBlock,startReceiving:DidStartReceivingResourceWithNameBlock,receivedCertificate:ReceivedCertificate){
        self.stateChange = stateChange
        self.reciveData = reciveData
        self.reciveStream = reciveStream
        self.finishReceiving = finishReceiving
        self.startReceiving = startReceiving
        self.certificateReceived = receivedCertificate
        
    }
    func onSessionUpdate(stateChange : StateChangeBlock,reciveData:DidReceiveDataBlock,reciveStream:DidReceiveStreamBlock,finishReceiving:DidFinishReceivingResourceWithNameBlock,startReceiving:DidStartReceivingResourceWithNameBlock){
        self.stateChange = stateChange
        self.reciveData = reciveData
        self.reciveStream = reciveStream
        self.finishReceiving = finishReceiving
        self.startReceiving = startReceiving
        
        
    }
    
    //    // didReceiveCertificate must be implemented to see the session functioning
    //    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
    //
    //        self.certificateReceived?(session: session, certificate: certificate, peerID: peerID, certificateHandler: certificateHandler)
    //
    //    }
    
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

// Data Sending Functions

extension MCSession{
    
    func sendString(text:String, peers:[MCPeerID])throws -> (){
        do{
            
            try self.sendData(text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, toPeers: peers, withMode: MCSessionSendDataMode.Reliable)
            
        }
        catch let error as NSError{
            throw error
        }
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





class GhostMaster:GhostSession{
    
    
    static var context:String = "GhostMaster"
    class var sharedSession :GhostChatSession {
        struct Singleton {
            
            static let instance = GhostChatSession(peer: ServiceIdentifier.peerID(), securityIdentity: nil, encryptionPreference: MCEncryptionPreference.Required)
        }
        return Singleton.instance
    }
    
}



class GhostChatSession:GhostSession{
    static var context:String = "GhostChat"
    class var sharedSession :GhostChatSession {
        struct Singleton {
            
            static let instance = GhostChatSession(peer: ServiceIdentifier.peerID(), securityIdentity: nil, encryptionPreference: MCEncryptionPreference.Required)
        }
        return Singleton.instance
    }
    
}




