//
//  ViewController.swift
//  notifserviceextension
//
//  Created by IRFAN TRIHANDOKO on 20/07/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.handleNotifData()
    }

    func handleNotifData() {
        let notifData = UserDefaults.standard.array(forKey: "NOTIF_DATA") as? [NSDictionary]
        let item = notifData?.last
        let aps = item?["aps"] as? NSDictionary
        let alert = aps?["alert"] as? NSDictionary
        let body = alert?["body"] as? String
        self.dataLbl.text = "Data Total: \(notifData?.count ?? 0)\nLatest Data: \(body ?? "")"
    }
    
    @objc func becomeActive() {
        self.handleNotifData()
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        self.handleNotifData()
    }
    
}

