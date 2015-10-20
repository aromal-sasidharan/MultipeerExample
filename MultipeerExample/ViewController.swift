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
    
    
    @IBOutlet weak var chatTextField: UITextField!
    
    var advertiser:AdvertiseManger?
    var browser : BrowserManager?
    var peerIDs :  [String : User] = [:]
//    var chatArray:[String]=[]
    var chatArray : NSMutableArray = ["Hello"]
    @IBOutlet weak var chatTableView: UITableView!

    @IBOutlet weak var loggerTextView: JRTranscriptView!
    
    @IBAction func sendClicked(sender: AnyObject) {
        
//        chatArray.addObject(self.chatTextField.text!)
//        self.chatTextField.text=""
//        self.chatTableView .reloadData()
        let test=GhostPacket(sender_id: ServiceIdentifier.peerID().displayName, sender_ip: "test2",isOnline:true)
        print(test.toJSON())
        WebSocketManger.sendString(test.toJSON() as String)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebSocketManger.onSocketUpdate({ (socket) -> () in
            
            
            
            }, disConnectBlock: { (socket, error) -> () in
                
                
                
            }, receiveMessageBlock: { (socket, text) -> () in
                
                
                print(text);
                let decoder  = JSONDecoder()
                let resultsDictionary = decoder.objectWithData((text as NSString).dataUsingEncoding(NSUTF8StringEncoding))
                
                let receiverId :String = (resultsDictionary?["receiver_id"])! as! String
                if(receiverId.containsString(ServiceIdentifier.peerID().displayName)){
                    
                }
                else
                {
                    NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                        for var i = 0; i < self.peerIDs.count; i++ {
                            let user = self.peerIDs.objectValueAtIndex(i) as User
                           self.sendText(text, toPeer: user.peerID!, isGhoast:true)
                        }

                        
                    }
                
                }
                
            }) { (socket, data) -> () in
                
                
        }
        Logger.setTextView(loggerTextView)
        
        self.contactList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.chatTableView.registerClass(ChatCellTableViewCell.self, forCellReuseIdentifier: "ChatCell")
        
        
        
        
        self.advertiser = AdvertiseManger(peer: ServiceIdentifier.peerID(), discoveryInfo: nil, serviceType: ServiceIdentifier.serviceName())
        self.browser = BrowserManager(peer: ServiceIdentifier.peerID(), serviceType: ServiceIdentifier.serviceName())
        self.advertiser?.startAdvertisingPeer()
        self.browser?.startBrowsingForPeers()
        self.setCallbacks()
        
        GhostChatSession.sharedSession.onSessionUpdate({ (session:MCSession, peerID:MCPeerID, state:MCSessionState) -> () in
            
            print("peer \(peerID) didChangeState: \(state.stringValue())")
            
            if state==MCSessionState.Connected {
                
                
                self.peerIDs[peerID.displayName]?.color = UIColor.greenColor()
            }
            else if state == MCSessionState.Connecting{
                self.peerIDs[peerID.displayName]?.color = UIColor.blueColor()
            }
            else{
                self.peerIDs[peerID.displayName]?.color = UIColor.redColor()
            }
            
            self.contactList.reloadData(true)
            
            }, reciveData: { (session, data, peerID) -> () in
                
                let stringData = data.toStringWithEncoding(NSUTF8StringEncoding)
                
                print("didReceiveData: \(stringData)")
                
            }, reciveStream: { (session, stream, streamName, peerID) -> () in
                
                
                print("reciveStream")
                
            }, finishReceiving: { (session, resourceName, peerID, localURL, error) -> () in
                
                print("finishReceiving \(resourceName)")
                
            }) { (session, resourceName, peerID, progress) -> () in
                
                print("didStartReceivingResourceWithName \(resourceName)")
                
        }
        
        GhostMaster.sharedSession.onSessionUpdate({ (session:MCSession, peerID:MCPeerID, state:MCSessionState) -> () in
            
            print("peer \(peerID) didChangeState: \(state.stringValue())")
            
            
            
            }, reciveData: { (session, data, peerID) -> () in
                
                
                let stringData = data.toStringWithEncoding(NSUTF8StringEncoding)
                print("didReceiveData.....................: \(stringData)")
                let decoder  = JSONDecoder()
                let resultsDictionary = decoder.objectWithData((stringData as NSString).dataUsingEncoding(NSUTF8StringEncoding))
                
                
                
                let type :String = (resultsDictionary?["type"])! as! String
                if(type.containsString("PresencePacket")){
                    let isOnline :Bool = (resultsDictionary?["isOnline"])! as! Bool
                    if(isOnline)
                    {
                        
                        let user=User(peerID: MCPeerID(displayName:"testArun"));
//                        user.id=(resultsDictionary?["sender_id"])! as! String
                        user.ipaddress=(resultsDictionary?["sender_ip"])! as! String
                        user.color=UIColor.redColor()
                        user.type=(resultsDictionary?["type"])! as! String
                         self.peerIDs[peerID.displayName] = user
                         self.contactList.reloadData(true)
                       
                    }else
                    {
                    
                    }
                    
                    
                    
                }

            }, reciveStream: { (session, stream, streamName, peerID) -> () in
                
                
                print("reciveStream")
                
            }, finishReceiving: { (session, resourceName, peerID, localURL, error) -> () in
                
                print("finishReceiving \(resourceName)")
                
            }) { (session, resourceName, peerID, progress) -> () in
                
                print("didStartReceivingResourceWithName \(resourceName)")
                
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func sendText(string:String, toPeer peerID:MCPeerID, isGhoast:Bool){
        if(isGhoast)
        {
            do{
                try GhostMaster.sharedSession.sendString(string, peers: [peerID])
            }
            catch let error as NSError{
                
                print("Error cannot send data \(error)")
                
            }

        
        }
        else
        {
            do{
                try GhostChatSession.sharedSession.sendString(string, peers: [peerID])
            }
            catch let error as NSError{
                
                print("Error cannot send data \(error)")
                
            }

        }
        
           }
    
    
    func setCallbacks()
    {
        self.browser?.onPeerUpdate(foundPeer: { (browser:MCNearbyServiceBrowser, peerID:MCPeerID, info) -> () in
            self.peerIDs[peerID.displayName] = User(peerID: peerID)
            
            self.contactList.reloadData(true)
            self.browser?.invitePeer(peerID, toSession: GhostMaster.sharedSession, withContext:GhostMaster.context.dataUsingEncoding(NSUTF8StringEncoding), timeout: 20)
            
            
            }, lostPeer: { (browser, peerID : MCPeerID) -> () in
                
                
                self.peerIDs.removeValueForKey(peerID.displayName)
                self.contactList.reloadData(true)
        })
        
        
        self.advertiser?.onAdvertiserUpdates({ (advertiser:MCNearbyServiceAdvertiser, peerID : MCPeerID, context:NSData?, invitationHandler : (Bool, MCSession)->Void) -> () in
            
            
            if let aContext = context{
                print("Peer has invited with context \(aContext.toStringWithEncoding(NSUTF8StringEncoding))")
            }
            
            print("Received invitation from peer \(peerID)")
            
            if context?.toStringWithEncoding(NSUTF8StringEncoding) == GhostChatSession.context{
                invitationHandler(true,GhostChatSession.sharedSession)
            }
            if context?.toStringWithEncoding(NSUTF8StringEncoding) == GhostMaster.context{
                invitationHandler(true,GhostMaster.sharedSession)
            }
            
            }, errorHandler: { (advertiser:MCNearbyServiceAdvertiser, error) -> () in
                
                print("Error in advertising \(error)")
                
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
        
        
        print(GhostMaster.sharedSession.connectedPeers)
        
    }
    
}



//Tableview Functiona

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        //        let peers = Array(self.peerIDs.values)
        //        let peer = peers[indexPath.row] as MCPeerID

        if(tableView.isEqual(self.chatTableView))
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatCellTableViewCell
             cell.textLabel?.text = self.chatArray.objectAtIndex(indexPath.row) as? String
            return cell;
        }else{
            let user = self.peerIDs.objectValueAtIndex(indexPath.row) as User
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.textLabel?.text = user.peerID!.displayName
            cell.backgroundColor = user.color
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            //        cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell;
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
    return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView.isEqual(self.chatTableView))
        {
            return (self.chatArray.count)
        }else
        {
            let count = self.peerIDs.count
            
            print("count \(count)")
            
            return count
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.isEqual(self.contactList))
        {
        let user = self.peerIDs.objectValueAtIndex(indexPath.row) as User
        

        print("Clicked peer name is \(user.peerID?.displayName)")
           
        

        if user.color == UIColor.redColor(){
            self.browser?.invitePeer(user.peerID!, toSession: GhostChatSession.sharedSession, withContext: GhostChatSession.context.dataUsingEncoding(NSUTF8StringEncoding), timeout: 20)
        }
        else if user.color == UIColor.greenColor(){
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                
                self.sendText("Hello", toPeer: user.peerID!, isGhoast:false)
            }
        }
        
//print(GhostMaster.sharedSession.connectedPeers)
//        self.browser?.invitePeer(user.peerID!, toSession: GhostMaster.sharedSession, withContext:GhostMaster.context.dataUsingEncoding(NSUTF8StringEncoding), timeout: 20)
        }

    }
    
//    func convertStringToDictionary(text: String) -> [String:String]? {
//        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
//            
//            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
//            return json! as! [String : String]
//        }
//        return nil
//    }
    
    
}
