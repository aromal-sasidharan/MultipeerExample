//
//  ArrayExtension.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/12/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation


extension Array {
    func indexOfObject(object : AnyObject) -> NSInteger {
        return self.indexOfObject(object)
    }
    
    mutating func removeObject(object : AnyObject) {
        for var index = self.indexOfObject(object); index != NSNotFound; index = self.indexOfObject(object) {
            self.removeAtIndex(index)
        }
    }
}
