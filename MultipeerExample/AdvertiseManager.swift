//
//  AdvertiseManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class AdvertiseManger:NSObject{
    
    private let serviceIdenfier = "GhostMaster"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    var advertiser : MCNearbyServiceAdvertiser?
    private var session : MCSession?
    init(session : MCSession){
        
        super.init()
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceIdenfier)
        advertiser?.delegate = self
        
        self.session = session
        
        
    }
    
    
    
    func startAdvertising(){
       
        advertiser?.startAdvertisingPeer()
    
    }
    
    func stopAdvertising(){
        advertiser?.stopAdvertisingPeer()
    }
    
    deinit{
        
        self.stopAdvertising();
        
    }
    
}


// Advertiser Delegate
extension AdvertiseManger : MCNearbyServiceAdvertiserDelegate{
    
     func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void){
        
        print("Did receive invitation from peer")
        
        invitationHandler(true,self.session!)
        
        
    }
    

    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError){
        
        print("Error in adverstising \(error)")
        
    }
    
}