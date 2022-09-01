//
//  ArrowSKScene.swift
//  Where Is France
//
//  Created by Briscoe, Corey M on 4/24/22.
// Corey Briscoe corbrisc
// Blythe Hammett blhamm
// William Quigley wquigley

import UIKit
import SpriteKit

class ArrowSKScene: SKScene {
    var arrow: SKShapeNode
    var spinSpeed: Double = 0
    var restingAngle: Double = 0
    var currentAngle: Double = 0
    var needsFirstAngle: Bool = true

    var appDelegate: AppDelegate?
    var myModel: Model?
    
    //adding this to change arrow color
    var quiver:[PointArrow] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func reload(){
        do{
            quiver = try context.fetch(PointArrow.fetchRequest())
        }catch{
            print("error")
        }
    }
    
    override init(size: CGSize) {
        self.arrow = SKShapeNode()
        super.init(size: size)
        // This makes (0, 0) be at the center of the screen
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let path = CGMutablePath()
        path.addRect(CGRect(x: -5, y: 15, width: 10, height: 40))
        path.move(to: CGPoint(x: -5, y: 55))
        path.addLine(to: CGPoint(x: -20, y: 55))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 20, y: 55))
        self.arrow.path = path
        //adding this for arrow color
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        let color = UIColor.white
        reload()
        if(quiver.count > 0){
            if let aColor = quiver[0].aColor{
                if let color = (self.myModel?.newArrowColor(newColor: aColor)){
                    self.arrow.fillColor = color
                    self.arrow.strokeColor = color
                }
            }
        }else{
            self.arrow.fillColor = color
            self.arrow.strokeColor = color
        }
        
        self.addChild(self.arrow)
        self.backgroundColor = .clear
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let _ = touch.location(in: self) // location on map is irrelevant
            // act on that touch in the scene at the location below:
            // add 3 radians per update call (? not sure the exact time that is) counterclockwise to spin speed
            self.spinSpeed += 3
        }
    }
    
    override func update(_ interval: TimeInterval) {
        // do something before frame updates on screen
        //print("\(self.spinSpeed) \(self.currentAngle) \(self.restingAngle)")
        if (self.spinSpeed > 0.018) {
            // decrease the spin speed over time
            self.spinSpeed *= 0.99
            self.currentAngle += spinSpeed
            self.currentAngle = self.currentAngle.truncatingRemainder(dividingBy: 2 * .pi)
            self.arrow.zRotation = self.currentAngle
        } else {
            if (self.spinSpeed == 0) {
                // no spinning is occurring, just ensure the arrow angle is always accurate
                self.arrow.zRotation = self.restingAngle
            } else {
                // at a low spin speed, just maintain the speed until it lands at the right angle
                //self.spinSpeed *= 0.9999
                //print(abs(self.currentAngle + self.restingAngle))
                // if currAngle = 2pi + restingAngle
                //                                +/- margin of error
                if ((abs(self.currentAngle - self.restingAngle - 2 * .pi)) < 0.01) {
                    // stop the arrow there
                    self.spinSpeed = 0
                    self.arrow.zRotation = self.restingAngle
                } else {
                    self.currentAngle += spinSpeed
                    self.currentAngle = self.currentAngle.truncatingRemainder(dividingBy: 2 * .pi)
                    self.arrow.zRotation = self.currentAngle
                }
            }
        }
        if (self.needsFirstAngle && self.restingAngle != 0) {
            self.arrow.zRotation = self.restingAngle
            self.currentAngle = self.restingAngle
            self.needsFirstAngle = false
            //print("Showing initial arrow angle at \(self.currentAngle) rad")
        }
        //adding to change arrow color
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        let color = UIColor.white
        reload()
        if(quiver.count > 0){
            if let aColor = quiver[0].aColor{
                if let color = (self.myModel?.newArrowColor(newColor: aColor)){
                    self.arrow.fillColor = color
                    self.arrow.strokeColor = color
                }
            }
        }else{
            self.arrow.fillColor = color
            self.arrow.strokeColor = color
        }
    }
    
    func updateRestingAngle(withAngle angle: Double) {
        self.restingAngle = angle * (-1)
        //print(restingAngle)
    }
    
    // necessary for subclassing SKScene ?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
}
