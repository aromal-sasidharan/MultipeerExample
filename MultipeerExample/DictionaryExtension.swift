//
//  DictionaryExtension.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/14/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation




extension Dictionary{
    
    
    
    func objectValueAtIndex(index:Int) -> Value {
        
        
        let array = Array(self.values)
        
        let s = array[index]
        
        
        return s
    }
    
    
    
}