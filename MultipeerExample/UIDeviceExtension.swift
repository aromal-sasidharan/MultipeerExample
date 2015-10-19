//
//  UIDeviceExtension.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/19/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation



extension UIDevice{
    
    
    var shortName : String  {
        
        
        switch(self.name){
            
            
        case "iPhone Simulator":
            return "IPHS"
        case "iPad Simulator":
            return "IPDS"
        default:
            return self.name
        }
        
        
    }
    
    
}