//
//  GameViewController.swift
//  testsprite
//
//  Created by Izumi Kiuchi on 2022/10/15.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion


class GameViewController: UIViewController {
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
            DispatchQueue.main.async {
                if let activity = data {
                    if activity.running == true {
                        print("Running")
                    }else if activity.walking == true {
                        print("Walking")
                    }else if activity.automotive == true {
                        print("Automative")
                        }
                    }
                }
            }
        }
        
        if CMPedometer.isStepCountingAvailable() {
            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            print("Number Of Steps == \(response.numberOfSteps)")
                            
//                            self.stepCounter.text = "Step Counter : \(response.numberOfSteps)"
                        }
                    }
                }
            }
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
