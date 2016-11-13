//
//  PingingScreenController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GooglePlaces

class PingingScreenController: UIViewController {
    
    var time: Int = 15
    var friendsToPing = [[String]]()
    var dest: GMSPlace?
    var decline_response = [[String]]()
//    var my_location: GMSPlace?
    //and hold your location and destination

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.updateDataStatus), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    //
    func updateDataStatus(timer: Timer) {
        //Pull the status of other people and store that to responses
        //put the decliners in the responses var
        if decline_response.count == friendsToPing.count {
            //no more people left
            let alertController = UIAlertController(title: "No One is Available!", message:
                "Try Calling Bear Walk Now", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Back to Home", style: UIAlertActionStyle.default,handler: {(action: UIAlertAction!) in
                self.performSegue(withIdentifier: "noOneAvailableSegueToHome", sender: self)
            }))
            //output alert
            self.present(alertController, animated: true, completion: nil)
        }
        
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
