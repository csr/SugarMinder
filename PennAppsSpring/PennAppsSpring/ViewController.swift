//
//  ViewController.swift
//  PennAppsSpring
//
//  Created by Cesare de Cal on 22/01/16.
//  Copyright © 2016 Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var labelCoins: UILabel!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var i = 0
    var coins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let myCoins = userDefaults.valueForKey("coins") {
            coins = Int(myCoins as! NSNumber)
        }
        labelCoins.text = String(coins)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func imageIsPressed(sender: AnyObject) {
        if i == 1  {
            let fishes1 = UIImageView(frame: CGRect(x: 40, y: screenSize.height/2, width: 209, height: 108))
            fishes1.image = UIImage(named: "fishes1")
            self.view.addSubview(fishes1)
        }
        i++
        coins += 10
        labelCoins.text = String(coins)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(coins, forKey: "coins")
        userDefaults.synchronize()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

