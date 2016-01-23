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
    var coins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let myCoins = userDefaults.valueForKey("coins") {
            coins = Int(myCoins as! NSNumber)
        }
        labelCoins.text = String(coins)
        animateWaterBubbles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func imageIsPressed(sender: AnyObject) {
        coins += 10
        labelCoins.text = String(coins)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(coins, forKey: "coins")
        userDefaults.synchronize()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func animateWaterBubbles() {
        for _ in 0...3 {
            let bubble1 = UIImageView()
            bubble1.image = UIImage(named: "bubble")
            let randomXOffset = CGFloat(arc4random_uniform(150))
            print(randomXOffset)
            bubble1.frame = CGRect(x: randomXOffset, y: 300, width: 10, height: 10)
            self.view.addSubview(bubble1)
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: view.bounds.size.width/3+randomXOffset, y: view.bounds.size.height - 100))
            path.addCurveToPoint(CGPoint(x: view.bounds.size.width/3+50+randomXOffset, y: view.bounds.size.height - 39), controlPoint1: CGPoint(x: 136+randomXOffset, y: view.bounds.size.height - 100), controlPoint2: CGPoint(x: 136+randomXOffset, y: view.bounds.size.height - 150))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = 15.0
            // add the animation
            bubble1.layer.addAnimation(anim, forKey: "animate position along path")
        }
    }
}

