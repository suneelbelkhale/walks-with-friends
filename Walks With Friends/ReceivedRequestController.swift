//
//  ReceivedRequestController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ReceivedRequestController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    var dist: String = "0.0"
    var name: String = "<Name>"
    var time: Int = 15
    
    var lat: Double = 37.867534
    var long: Double = -122.257326
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name + " is Requesting a Walk";
        distanceLabel.text = dist + " mi";
        timeLabel.text = String(time) + " min"
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        viewMap.camera = camera
        viewMap.isMyLocationEnabled = true
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Unit 1"
        marker.snippet = "Walk time: 12 min"
        marker.map = viewMap
        
        goButton.backgroundColor = UIColor.clear
        goButton.layer.cornerRadius = 5
        goButton.layer.borderWidth = 2
        goButton.layer.borderColor = UIColor.purple.cgColor
        goButton.setTitleColor(UIColor.purple, for: .normal)
        
        declineButton.backgroundColor = UIColor.clear
        declineButton.layer.cornerRadius = 5
        declineButton.layer.borderWidth = 2
        declineButton.layer.borderColor = UIColor.purple.cgColor
        declineButton.setTitleColor(UIColor.purple, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
//    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        
        
        
        // Creates a marker in the center of the map.
        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        marker.title = "Memorial Stadium"
//        marker.snippet = "Berkeley"
//        marker.map = viewMap

        
        
//    }

//    func locationManager(_ manager: CLLocationManager,
//                         didUpdateLocations locations: [CLLocation])
//    {
//        let latestLocation: CLLocation = locations[locations.count - 1]
//        
//        lat = latestLocation.coordinate.latitude
//        long = latestLocation.coordinate.longitude
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        marker.title = "Memorial Stadium"
//        marker.snippet = "Berkeley"
//        //marker.map = mapView
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WaitingScreenController,
            segue.identifier == "AcceptRequestSegue"
        {
            destination.countTime = time
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
