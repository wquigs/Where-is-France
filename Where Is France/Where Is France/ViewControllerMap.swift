//
//  ViewController.swift
//  Where Is France
//
//  Created by will quigley on 4/16/22.
// Corey Briscoe corbrisc
// Blythe Hammett blhamm
// William Quigley wquigley

import UIKit

import MapKit
import CoreData
import SpriteKit

class ViewControllerMap: UIViewController, CLLocationManagerDelegate {

    var appDelegate: AppDelegate?
    var myModel: Model?
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var mySKView: SKView!
    @IBOutlet weak var myDistanceLabel: UILabel!
    
    var scene: ArrowSKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        //print(coreDataContainer)
        // to use the Location Manager when our app is running in foreground:
        self.locationManager.requestWhenInUseAuthorization()
       
        // to always use Location Manager:
        // self.locationManager.requestAlwaysAuthorization()
        //self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            
            self.myMapView.userTrackingMode = .follow
        }
        
        self.scene = ArrowSKScene(size: self.myMapView.bounds.size)
        
        self.mySKView.allowsTransparency = true
        self.mySKView.backgroundColor = .clear
        self.mySKView.presentScene(self.scene)
        
        if let user_location = self.locationManager.location {
            if let angle = self.myModel?.getAngle(user_location: user_location) {
                self.scene?.updateRestingAngle(withAngle: angle)
            }
            let distance = (self.myModel?.computeDistance(coordinate: user_location))!
            self.myModel?.processDistance(distance: distance, date: Date())
        }
    }
    
    // called when user location updates
    // it will call methods from the model
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let distance = (self.myModel?.computeDistance(coordinate: locations[0]))!
        let date = Date()
        self.myModel?.processDistance(distance: distance, date: date)
        self.myDistanceLabel.text = "You're \(Int(distance)) meters from France!"
        if let angle = self.myModel?.getAngle(user_location: locations[0]) {
            self.scene?.updateRestingAngle(withAngle: angle)
        }
        
    }

    
    

}

