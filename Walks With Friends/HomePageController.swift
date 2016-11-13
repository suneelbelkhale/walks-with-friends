//
//  ViewController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit

class HomePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var bearWalkButton: UIButton!
    @IBAction func callBearWalk(_ sender: UIButton) {
        
        let refreshAlert = UIAlertController(title: "Call Bear Walk", message: "Are you sure you want to call?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Calling Bear Walk")
            self.callNumber(phoneNumber: "5106429255")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Not Calling Bear Walk")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    var  friends = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load all the reqeusts
        friends = [["Logan", "0.5"],["Sachit", "0.1"],["Suneel", "0.2"]] //for now
        
        friendTableView.delegate = self
        friendTableView.dataSource = self
        
        friends.sort{Double($0[1] as String)! < Double($1[1] as String)!}
        
        bearWalkButton.backgroundColor = UIColor.clear
        bearWalkButton.layer.cornerRadius = 5
        bearWalkButton.layer.borderWidth = 2
        bearWalkButton.layer.borderColor = UIColor.purple.cgColor
        bearWalkButton.setTitleColor(UIColor.purple, for: .normal)
        
        requestButton.backgroundColor = UIColor.clear
        requestButton.layer.cornerRadius = 5
        requestButton.layer.borderWidth = 2
        requestButton.layer.borderColor = UIColor.purple.cgColor
        requestButton.setTitleColor(UIColor.purple, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var friendTableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count // Most of the time my data source is an array of something...  will replace with the actual name of the data source
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Note:  Be sure to replace the argument to dequeueReusableCellWithIdentifier with the actual identifier string!
        let cellIdentifier = "FriendID"
//        let cell = tableView.dequeueReusableCell(withIdentifier: , for: indexPath) as UITableViewCell
//        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // set cell's textLabel.text property
        // set cell's detailTextLabel.text property
        cell.textLabel!.text = friends[indexPath.row][0]
        cell.detailTextLabel!.text = friends[indexPath.row][1]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("Clicked a cell")
        // pass any object as parameter, i.e. the tapped row
        performSegue(withIdentifier: "ShowReceivedSegue", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ReceivedRequestController,
            let friendIndex = friendTableView.indexPathForSelectedRow?.row,
            segue.identifier == "ShowReceivedSegue"
        {
            destination.name = friends[friendIndex][0]
            destination.dist = friends[friendIndex][1]
//            print("FINISHED")
        }
        
    }
}
