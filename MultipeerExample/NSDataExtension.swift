//
//  NSDataExtension.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/14/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation



extension NSData{
    
    func toStringWithEncoding(encoding:NSStringEncoding)  -> String{
        
        return    NSString(data: self, encoding: encoding) as! String
        
    }
 
}