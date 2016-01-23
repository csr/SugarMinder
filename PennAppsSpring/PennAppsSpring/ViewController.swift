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
        let square = UIImageView()
        square.image = UIImage(named: "bubble")
        square.frame = CGRect(x: 55, y: 300, width: 20, height: 20)
        square.backgroundColor = UIColor.redColor()
        self.view.addSubview(square)
        
        // randomly create a value between 0.0 and 150.0
        let randomYOffset = CGFloat( arc4random_uniform(150))
        
        // for every y-value on the bezier curve
        // add our random y offset so that each individual animation
        // will appear at a different y-position
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: view.bounds.size.width/3 ,y: view.bounds.size.height - 100 + randomYOffset))
        path.addCurveToPoint(CGPoint(x: view.bounds.size.width/3+50, y: view.bounds.size.height - 50 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
        
        // create the animation
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.CGPath
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 5.0
        
        // add the animation
        square.layer.addAnimation(anim, forKey: "animate position along path")
    }
}

