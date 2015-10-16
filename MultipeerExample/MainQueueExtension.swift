//
//  MainQueueExtension.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/16/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import Foundation


extension UITableView{
    
    
    func reloadData(inMainQueue:Bool){
        
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            self.reloadData()
            
        }
    }
    
}