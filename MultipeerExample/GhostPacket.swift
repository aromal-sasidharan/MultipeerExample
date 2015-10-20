//
//  GhostPacket.swift
//  MultipeerExample
//
//  Created by Arun J on 10/19/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import UIKit


class GhostPacket: NSObject {
     var type:String=""
     var sender_id:String=""
     var receiver_id:String=""
     var sender_ip:String=""
     var receiver_ip:String=""
     var sender_unique_name:String=""
     var isOnline:Bool=false
     var message:String=""
    
    
    init(sender_id:String,sender_ip:String) {
        self.sender_id=sender_id
        self.sender_ip=sender_ip
        super.init()
    }
    init(sender_id:String,sender_ip:String,isOnline:Bool){
        
       
        self.sender_id=sender_id
        self.sender_ip=sender_ip
        self.type = "PresencePacket"
        self.isOnline = isOnline
         super.init()
    }
    internal func toJSON()-> NSString{
        
        let dictionary:NSDictionary = getDictionary()
        let theJSONData = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
        let theJSONText = NSString(data: theJSONData!,
            encoding: NSASCIIStringEncoding)
        print("JSON string = \(theJSONText!)")
    return theJSONText!;
    }
    init(sender_id: String, sender_ip: String, message: String) {
        
        super.init()
        self.sender_id=sender_id
        self.sender_ip=sender_ip
        self.type = "TextPacket"
        self.message = message
    }
}
