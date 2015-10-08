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

    var sessionManager : SessionManager?
    var advertiser:AdvertiseManger?
    var browser : BrowserManager?
    
    @IBOutlet weak var loggerTextView: JRTranscriptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.setTextView(loggerTextView)
        
        
        Logger.log("Hello Iam Here")
        
        
        
        sessionManager  = SessionManager()
        
        let session = sessionManager?.session
        advertiser = AdvertiseManger(session: session!)
        browser = BrowserManager(session: session!)
        
        browser?.startBrowsing()
        
        
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

