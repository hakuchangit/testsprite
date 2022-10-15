//
//  GameScene.swift
//  testsprite
//
//  Created by Izumi Kiuchi on 2022/10/15.
//

import SpriteKit
import GameplayKit
import UIKit
import Foundation
import CoreMotion


class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
      
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     //   for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        
       hosuu()
    }
    
    func hosuu(){
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
                if error == nil { print("cccc ")
                    if let response = data {
                        DispatchQueue.main.async {
                            print("Number Of Steps == \(response.numberOfSteps)")
                            
                            self.label?.text = "Step Counter : \(response.numberOfSteps)"
                        }
                    }
                }
            }
        }
    }
    
}
