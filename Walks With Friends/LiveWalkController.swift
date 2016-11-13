//
//  LiveWalkController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GooglePlaces

class LiveWalkController: UIViewController {
    let placeID = "ChIJF9u9tC98hYAR2WwO7CbPeoM"
    var placesClient: GMSPlacesClient = GMSPlacesClient.shared()

    var loc: GMSPlace?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place placeID \(place.placeID)")
                print("Place attributions \(place.attributions)")
                self.loc = place
            } else {
                print("No place details for \(self.placeID)")
            }
        })
        
//        let testURL = NSURL(string: "comgooglemaps://")!
//        if UIApplication.shared.canOpenURL(testURL as URL) {
//            let directionsRequest = "comgooglemaps://?daddr=" + (loc?.name)!
//            print(directionsRequest)
//            let directionsURL = NSURL(string: directionsRequest)!
//            UIApplication.shared.openURL(directionsURL as URL)
//        } else {
//            NSLog("Can't use comgooglemaps:// on this device.")
//        }
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
