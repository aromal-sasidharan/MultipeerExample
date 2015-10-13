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
    
     func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void){
        
        print("Did receive invitation from peer \(peerID)")
        
        invitationHandler(true,GhostChatSession.sharedSession)
        
        
    }
    

    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError){
        
        print("Error in adverstising \(error)")
        
    }
    
}