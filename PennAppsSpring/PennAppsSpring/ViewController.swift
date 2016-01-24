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
    @IBOutlet weak var viewStore: UIView!
    @IBOutlet weak var stepperFishes: UIStepper!
        let screenSize: CGRect = UIScreen.mainScreen().bounds
    var coins = 0
    var numberOfFishes = 1
    
    @IBOutlet weak var labelNumberOfFishesSelected: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStore.hidden = true
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let myCoins = userDefaults.valueForKey("coins") {
            coins = Int(myCoins as! NSNumber)
        }
        labelCoins.text = String(coins)
        animateWaterBubbles()
        animateFish()
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
    @IBAction func showStoreMenu(sender: AnyObject) {
        viewStore.hidden = false
        labelNumberOfFishesSelected.text = "Add a fish to your aquarium."
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func animateFish() {
        for i in 1...numberOfFishes {
            let fish = UIImageView(image: UIImage(named: "fishInsulin"))
            let randomWidth = CGFloat(arc4random_uniform(100))
            let randomXOffset = CGFloat(arc4random_uniform(200))
            let randomYOffset = CGFloat(arc4random_uniform(200))
            let randomDuration = CGFloat(arc4random_uniform(30)) + 10

            fish.frame = CGRect(x: view.bounds.width+150+randomXOffset, y: view.bounds.height-100+randomYOffset, width: randomWidth, height: randomWidth)
            view.addSubview(fish)
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: view.bounds.width + 50 + randomXOffset, y: view.bounds.size.height - 100 - randomYOffset))
            path.addCurveToPoint(CGPoint(x: -50, y: view.bounds.size.height-100), controlPoint1: CGPoint(x: view.bounds.width + 50, y: view.bounds.size.height - 300), controlPoint2: CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height - 100))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAutoReverse
            anim.repeatCount = Float.infinity
            anim.duration = CFTimeInterval(randomDuration)
            // add the animation
            fish.layer.addAnimation(anim, forKey: "animate position along path")
        }
    }
    
    func animateWaterBubbles() {
        for i in 0...50 {
            let bubble1 = UIImageView()
            bubble1.image = UIImage(named: "bubble")
            let randomXOffset = CGFloat(arc4random_uniform(400))
            let randomYOffset = CGFloat(arc4random_uniform(300))
            bubble1.frame = CGRect(x: randomXOffset, y: 300, width: 10, height: 10)
            self.view.addSubview(bubble1)
            
            // for every y-value on the bezier curve
            // add our random y offset so that each individual animation
            // will appear at a different y-position
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: view.bounds.size.width/3-randomXOffset, y: view.bounds.size.height - 100))
            path.addCurveToPoint(CGPoint(x: view.bounds.size.width/3+50-randomXOffset, y: view.bounds.size.height - randomYOffset), controlPoint1: CGPoint(x: 136-randomXOffset, y: view.bounds.size.height - randomYOffset), controlPoint2: CGPoint(x: 136-randomXOffset + randomYOffset, y: view.bounds.size.height - randomYOffset - 100 - randomXOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = 30
            // add the animation
            bubble1.layer.addAnimation(anim, forKey: "animate position along path")
        }
    }
    
    func setUpStepper() {
        stepperFishes.minimumValue = 1
        stepperFishes.maximumValue = 10
    }
        
    @IBAction func hasStepperValueChanged(sender: UIStepper) {
        if Int(sender.value) < 1 {
            labelNumberOfFishesSelected.text = "Currently \(Int(sender.value)) fish"
        } else {
            labelNumberOfFishesSelected.text = "Currently \(Int(sender.value)) fishes"
        }
        animateFish()
        coins -= 100
        labelCoins.text = "\(coins)"
    }
    
    
    @IBAction func pressOnCancel(sender: AnyObject) {
        viewStore.hidden = true
    }
}

