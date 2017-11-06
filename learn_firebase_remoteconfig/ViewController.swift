//
//  ViewController.swift
//  learn_firebase_remoteconfig
//
//  Created by iq3_makepa on 2017/11/06.
//  Copyright © 2017年 iq3. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {

    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 30) { [weak self] (status, error) in
            if status == .success {
                print("Config fetched!")
                RemoteConfig.remoteConfig().activateFetched()
            } else {
                print("Config not fetched")
            }
            self?.updateViews()
        }
        self.updateViews()
    }
    
    private func updateViews(){
        let config = RemoteConfig.remoteConfig()
        guard var welcomeMsg = config["welcome_message"].stringValue else {
            return
        }
        if config["welcome_message_caps"].boolValue {
            welcomeMsg = welcomeMsg.uppercased()
        }
        
        label.text = welcomeMsg
    }
}

