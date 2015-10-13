//
//  BrowserManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class BrowserManager:MCNearbyServiceBrowser{
    
    typealias FoundPeer = ((browser: MCNearbyServiceBrowser, peerID: MCPeerID, info: [String : String]?)->())
    typealias LostPeer = (browser: MCNearbyServiceBrowser, peerID: MCPeerID) -> ()
    
    
    var foundPeer:FoundPeer?
    var lostPeer:LostPeer?
    
    
    private var serviceBrowser : MCNearbyServiceBrowser?
    
    override init(peer: MCPeerID, serviceType: String){
        
        super.init(peer: peer, serviceType: serviceType)
        
        self.delegate  = self
        
    }
    
    
    
}


extension  BrowserManager : MCNearbyServiceBrowserDelegate{
    
    func onPeerUpdate(foundPeer foundPeer:FoundPeer, lostPeer:LostPeer){
        
        self.foundPeer = foundPeer
        self.lostPeer = lostPeer
    }
    
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?){
        
        
        print("found peer  \(peerID)")
        self.foundPeer?(browser: browser, peerID: peerID, info: info)
        
        //        browser.invitePeer(peerID, toSession: GhostChatSession.sharedSession, withContext: nil, timeout: 10)
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID){
        
        print("lost peer  \(peerID)")
        
        self.lostPeer?(browser: browser, peerID: peerID)
    }
    
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError){
        print("bowser error  \(error)")
    }
    
}