//
//  ViewController.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/5/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import UIKit
import LoggerFrameWork
class ViewController: UIViewController {

    
    var advertiser:AdvertiseManger?
    var browser : BrowserManager?
    
    @IBAction func sendData(sender: AnyObject) {
        
        
        print(GhostChatSession.sharedSession.connectedPeers)
        
    }
    @IBOutlet weak var loggerTextView: JRTranscriptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Logger.enableLog(true)
        Logger.setTextView(loggerTextView)
        
        
        Logger.log("Hello Iam Here")
        
        
        
        
        
       
        advertiser = AdvertiseManger()
        browser = BrowserManager()
        
        browser?.startBrowsing()
        
       

        
        GhostChatSession.sharedSession.onSessionUpdate({ (session, peerID, state) -> () in
            
             NSLog("%@","peer \(peerID) didChangeState: \(state.stringValue())")
            
            }, reciveData: { (session, data, peerID) -> () in
                
                 print("didReceiveData: \(data)")
                
            }, reciveStream: { (session, stream, streamName, peerID) -> () in
 
                 print("reciveStream")
                
            }, finishReceiving: { (session, resourceName, peerID, localURL, error) -> () in
                
                print("finishReceiving \(resourceName)")
                
                
            }) { (session, resourceName, peerID, progress) -> () in
                
                
                print("didStartReceivingResourceWithName \(resourceName)")
        }
        
        
       
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAdvertise(sender: AnyObject) {
        
        self.advertiser?.startAdvertising()
    }
    
}

