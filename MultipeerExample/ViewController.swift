//
//  ViewController.swift
//  MultipeerExample
//
//  Created by Aromal Sasidharan on 10/5/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import UIKit

import MultipeerConnectivity
import LoggerUI

class ViewController: UIViewController {

    @IBOutlet weak var contactList: UITableView!
    
    
    
    var advertiser:AdvertiseManger?
    var browser : BrowserManager?
    var peerIDs :  [MCPeerID]? = []
   
    @IBOutlet weak var loggerTextView: JRTranscriptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Logger.setTextView(loggerTextView)
        
        self.contactList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        

      
        self.advertiser = AdvertiseManger(peer: ServiceIdentifier.peerID(), discoveryInfo: nil, serviceType: ServiceIdentifier.serviceName())
        self.browser = BrowserManager(peer: ServiceIdentifier.peerID(), serviceType: ServiceIdentifier.serviceName())
        self.advertiser?.startAdvertisingPeer()
        self.browser?.startBrowsingForPeers()
        self.setBrowserUpdater()
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
    
    
    func setBrowserUpdater()
    {
        self.browser?.onPeerUpdate(foundPeer: { (browser, peerID, info) -> () in
            
            print("Here")
            
            self.peerIDs?.append(peerID)
            
            self.contactList.reloadData()
            
            }, lostPeer: { (browser, peerID : MCPeerID) -> () in
                
             
            self.peerIDs?.removeObject(peerID)
            self.contactList.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }

    
    
}

//IBActions
extension ViewController{
    
    @IBAction func startAdvertise(sender: AnyObject) {
        
      
    }
    
    @IBAction func sendData(sender: AnyObject) {
        
        
        print(GhostChatSession.sharedSession.connectedPeers)
        
    }
    
}



//Tableview Functiona

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        let peerID = self.peerIDs?[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = peerID?.displayName

        return cell;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = self.peerIDs?.count ?? 0
        
        print("count \(count)")
        return count
    }
    
    
    
    
}
















