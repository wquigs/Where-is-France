//
//  Model.swift
//  Where Is France
//
//  Created by will quigley on 4/16/22.
// Corey Briscoe corbrisc
// Blythe Hammett blhamm
// William Quigley wquigley

import Foundation

import CoreLocation
import UIKit

class Model {

    var distances: [distanceDate] = []
    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    let franceLocation = CLLocation(latitude: 46.2276, longitude: 2.2137)
    
    func computeDistance(coordinate: CLLocation) -> CLLocationDistance {
        let distanceInMeters = coordinate.distance(from: franceLocation)
        //print("distance from France is \(distanceInMeters) meters")
        return distanceInMeters
    }
    
    func processDistance(distance: CLLocationDistance, date: Date) {
        // assume distances array is sorted in ascending order on distance
        // check for new best distances
        // specifically, first, see if this distance is a better record for today
        // also, check whether today's date is represented in the data model
        var todayHasRecord = false
        for i in 0..<self.distances.count {
            if (Calendar.current.isDateInToday(self.distances[i].date)) {
                todayHasRecord = true
                if (distance < self.distances[i].distance) {
                    // a new closest distance today
                    self.distances[i] = distanceDate(distance: distance, date: date)
                    sortDistancesArray() // it might take the place of an existing record
                    print(self.distances)
                    return // exit the method so no duplicated dates are added
                }
            }
        }
        // otherwise, check if a new best distance record should be created for today
        // either because it is better than the worst one or because there just aren't 3 yet
        if let worstRecord = self.distances.last {
            if (distance < worstRecord.distance || (self.distances.count < 3 && !todayHasRecord)) {
                // if it's better than 3rd place's record, it makes top three, or if there aren't yet 3
                self.distances.append(distanceDate(distance: distance, date: date))
                sortDistancesArray()
            } // notice the if-if-else structure, this does *not* mistakenly append when the inner if fails!
        } else {
            // if there's no last element, there's no elements at all,
            // so we have a winner
            self.distances.append(distanceDate(distance: distance, date: date))
            // no need to sort
        }
        //print("the distances are \(self.distances)")
    }
    
    func getAngle(user_location: CLLocation) -> Double {
        let lat1 = self.degreesToRadians(degrees: user_location.coordinate.latitude)
        let lon1 = self.degreesToRadians(degrees: user_location.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: self.franceLocation.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: self.franceLocation.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        let degreesBearing = self.radiansToDegrees(radians: radiansBearing)
        
        if (degreesBearing >= 0) {
            let radians = degreesToRadians(degrees: degreesBearing)
            return radians
        }
        
        else {
            let radians = degreesToRadians(degrees: (degreesBearing + 360.0))
            return radians
        }
    }
    
    func degreesToRadians(degrees: Double) -> Double {
        return degrees * (.pi / 180)
    }
    
    func radiansToDegrees(radians: Double) -> Double {
        return radians * (180 / .pi)
    }

    //arrow color
    func newArrowColor(newColor: String) -> UIColor{
        if(newColor == "red"){
            return UIColor.red
        }else if(newColor == "blue"){
            return UIColor.blue
        }else if(newColor == "green"){
            return UIColor.green
        }else if(newColor == "yellow"){
            return UIColor.yellow
        }else if(newColor == "orange"){
            return UIColor.orange
        }else{
            return UIColor.systemPink
        }
    }
    
    func sortDistancesArray() {
        // called when distances array has more than three elements,
        // or just needs sorting.
        // mutates distances array to contain only the top 3 records
        // and puts them in ascending order by distance
        var bestDistanceDoubles: [Double] = []
        var resultDistances: [distanceDate] = []
        for dD_i in self.distances {
            bestDistanceDoubles.append(dD_i.distance)
        }
        // use a double loop to account for worst-case scenario where
        // the array is in descending order (somehow)
        while (resultDistances.count < distances.count) {
            // find the element in distances with the smallest distance each time
            // and remove that smallest distance from bestDistanceDoubles when it's matched
            //print("Updating distances...")
            let minDistanceRemaining = bestDistanceDoubles.min() // necessary b/c of removeAll
            for i in 0..<self.distances.count { // typically, i = 0, 1, then 2
                if (self.distances[i].distance == minDistanceRemaining) {
                    resultDistances.append(self.distances[i])
                    bestDistanceDoubles.removeAll(where: {$0 == minDistanceRemaining})
                    // the above Swift-specific syntax is very much like a lambda function
                    // removes those element(s) where the expression is true
                    break
                }
            }
        }
        self.distances = resultDistances
        
    }
    
    // This was Will's code, I (Corey) removed its usage
    // Left for posterity :)
    /*
    func sortDD(distances: [distanceDate]) -> [distanceDate]{
        var topThree: [distanceDate] = []
        for dd in distances{
            var count = 0
            for ddd in distances{
                if(dd.distance <= ddd.distance){
                    count = count + 1
                }
            }
            if((count + 3) >= distances.count){
                topThree.append(dd)
            }
        }
        return topThree
    }
    */
    struct distanceDate{
        var distance: Double
        var date: Date
        
    }
}
