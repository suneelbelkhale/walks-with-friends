//
//  WaitingScreenController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class WaitingScreenController: UIViewController {
    
    //need to pass in both peoples' locations
    //place ___1
    //place ___2
    
    var lat: Double = 37.867534
    var long: Double = -122.257326
    var countTime: Int = 0; //in minutes, set by previous frame
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownLabel.text = "Depart in " + String(countTime) + " minutes"
        _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.updateCountdown), userInfo: nil, repeats: true)
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        viewMap.camera = camera
        viewMap.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Unit 1"
        marker.snippet = "Berkeley"
        marker.map = viewMap
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCountdown(timer: Timer) {
        countTime = countTime - 1
        if countTime < 1 {
            //stop counting
            timer.invalidate()
            countdownLabel.text = "Depart Now!"
        }
        else{
            countdownLabel.text = "Depart in " + String(countTime) + " minutes"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LiveWalkController,
            segue.identifier == "LiveWalkSegue"
        {
            //also pass on the locations
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
