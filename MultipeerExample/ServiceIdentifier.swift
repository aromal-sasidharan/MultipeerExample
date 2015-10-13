//
//  ServiceIdentifier.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/13/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity



class ServiceIdentifier{
    
    private var name : String{
        return "GhostMaster"
    }
    
    private var peerId:MCPeerID
        
    
    private class var sharedManager :ServiceIdentifier {
        struct Singleton {
            
            static let instance = ServiceIdentifier()
        }
        return Singleton.instance
    }
    
    init(){
     
        
        self.peerId =  MCPeerID(displayName: UIDevice.currentDevice().name)
    }
    
    class func peerID() -> MCPeerID {
        
        
        return ServiceIdentifier.sharedManager.peerId
    }
    
    
    class func serviceName() -> String {
        
        
        return ServiceIdentifier.sharedManager.name
    }
    
    
    
    
}