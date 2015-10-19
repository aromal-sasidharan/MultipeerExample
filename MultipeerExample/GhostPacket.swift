//
//  GhostPacket.swift
//  MultipeerExample
//
//  Created by Arun J on 10/19/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import UIKit


class GhostPacket: NSObject {
    internal var type:String=""
    internal var sender_id:String=""
    internal var receiver_id:String=""
    internal var sender_ip:String=""
    internal var receiver_ip:String=""
    internal var sender_unique_name:String=""
    
    init(sender_id:String,sender_ip:String) {
        self.sender_id=sender_id
        self.sender_ip=sender_ip
        super.init()
    }
    internal func toJSON(){
        
        let dictionary:NSDictionary = getDictionary()
        let theJSONData = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
        let theJSONText = NSString(data: theJSONData!,
            encoding: NSASCIIStringEncoding)
        print("JSON string = \(theJSONText!)")
//    return json_encode(self);
    }

}
class PresencePacket:GhostPacket {
    internal var isOnline:Bool?
    
    override init(sender_id:String,sender_ip:String){
    
    super.init(sender_id: sender_id,sender_ip: sender_ip)
        
    self.type = "PresencePacket";
    self.isOnline = false;
    
    }

}
class TextPacket: GhostPacket {
    internal var message:String=""
     init(sender_id: String, sender_ip: String, message: String) {
     
    super.init(sender_id: sender_id, sender_ip: sender_ip)
    self.type = "TextPacket";
    self.message = message;
    }

}