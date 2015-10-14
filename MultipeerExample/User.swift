//
//  User.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/14/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class User {
    var color:UIColor = UIColor.redColor()
    var peerID:MCPeerID
    init(peerID:MCPeerID){
        
        self.peerID = peerID
    }
    
}