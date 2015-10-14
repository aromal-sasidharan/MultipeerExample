//
//  AdvertiseManager.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/6/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class AdvertiseManger:MCNearbyServiceAdvertiser{
    
    typealias InvitationUpdater = ((advertiser: MCNearbyServiceAdvertiser, peerID: MCPeerID, context: NSData?, invitationHandler: (Bool, MCSession)-> Void)->())
    typealias ErrorHandler = (advertiser: MCNearbyServiceAdvertiser, error: NSError) -> ()
    
   
    
    var invitationUpdater:InvitationUpdater?
    var errorHandler:ErrorHandler?
    
    var advertiser : MCNearbyServiceAdvertiser?
    
    
   
    override init(peer: MCPeerID, discoveryInfo: [String : String]?, serviceType: String){
        
        super.init(peer: peer, discoveryInfo: discoveryInfo, serviceType: serviceType)
        
        self.delegate = self
        
        
        
        
        
        
    }
    
    
    
 
    deinit{
        
        self.stopAdvertisingPeer();
        
    }
    
}


// Advertiser Delegate
extension AdvertiseManger : MCNearbyServiceAdvertiserDelegate{
    
    
    
    func onAdvertiserUpdates(invitationUpdater:InvitationUpdater,errorHandler:ErrorHandler) {
        self.invitationUpdater = invitationUpdater
        self.errorHandler = errorHandler
        
    }
    
     func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void){
        
       
        
//        invitationHandler(true,GhostChatSession.sharedSession)
        
        self.invitationUpdater?(advertiser: advertiser, peerID: peerID, context: context, invitationHandler: invitationHandler)
    }
    

    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError){
        
        print("Error in adverstising \(error)")
        
        self.errorHandler?(advertiser: advertiser, error: error)
        
    }
    
}