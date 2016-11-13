//
//  MatchScreenController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MatchScreenController: UIViewController {

    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var goButton: UIButton!
    var lat: Double = 37.867534
    var long: Double = -122.257326
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        viewMap.camera = camera
        viewMap.isMyLocationEnabled = true
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = "Unit 1"
        marker.snippet = "Berkeley"
        marker.map = viewMap
        
        goButton.backgroundColor = UIColor.clear
        goButton.layer.cornerRadius = 5
        goButton.layer.borderWidth = 2
        goButton.layer.borderColor = UIColor.purple.cgColor
        goButton.setTitleColor(UIColor.purple, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
