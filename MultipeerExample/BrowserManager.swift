//
//  BrowserManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class BrowserManager:NSObject{
    
    private let serviceIdenfier = "GhostMaster"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    private var serviceBrowser : MCNearbyServiceBrowser?
    private var session : MCSession?
    init(session : MCSession){
        
        super.init()
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceIdenfier)
        
        self.session = session
        
        serviceBrowser?.delegate = self
        
    }
    
    
    func startBrowsing(){
        
        
        serviceBrowser?.startBrowsingForPeers()
        
    }
    
}


extension  BrowserManager : MCNearbyServiceBrowserDelegate{
    
    
  
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?){
        
        
        print("found peer  \(peerID)")
        
        browser.invitePeer(peerID, toSession: self.session!, withContext: nil, timeout: 10)
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID){
        
        print("lost peer  \(peerID)")
    }
    
 
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError){
           print("bowser error  \(error)")
    }
    
}