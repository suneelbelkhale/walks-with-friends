//
//  WalkRequestController.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import GooglePlaces

class SendRequestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var findFriendsButton: UIButton!
    @IBOutlet weak var selectedTime: UIPickerView!
    @IBOutlet weak var selectedOutputLabel: UILabel!
    var friendList = [[String]]()
    var chosenFriends = [[String]]()
    var timePicked = 15
    
    
    var dest: GMSPlace?
//    var my_loc: GMSPlace?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    //and hold location as well ^^
    
    
    @IBOutlet weak var searchBarView: UIView!
    var pickerDataSource = [Int]()
    
    @IBOutlet weak var availableFriends: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //this would be loaded from database of friends and cross checked with their distances
        friendList = [["Annie", "1.0"],["Quoc", "0.2"],["Ashu", "0.6"]]
        
        pickerDataSource = [5,10,15,20,25,30,35,40,45,50,55,60]
        availableFriends.delegate = self
        availableFriends.dataSource = self
        
        self.selectedTime.dataSource = self
        self.selectedTime.delegate = self
        
        friendList.sort{Double($0[1] as String)! < Double($1[1] as String)!}
        
        selectedOutputLabel.text = "None Selected"
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        
        searchBarView.addSubview((searchController?.searchBar)!)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
        
        findFriendsButton.backgroundColor = UIColor.black
        findFriendsButton.layer.cornerRadius = 5
        findFriendsButton.layer.borderWidth = 2
        findFriendsButton.layer.borderColor = UIColor.black.cgColor
        findFriendsButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return String(pickerDataSource[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.timePicked = Int(pickerDataSource[row])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count // Most of the time my data source is an array of something...  will replace with the actual name of the data source
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
        cell.textLabel!.text = friendList[indexPath.row][0]
        cell.detailTextLabel!.text = friendList[indexPath.row][1]
        cell.accessoryType = .none
        return cell
    }
    
    func removeSpecific(element: [String]) {
        print("Entered delete: ", chosenFriends)
        chosenFriends = chosenFriends.filter { $0[0] != element[0] }
    }
    func contains(element: [String]) -> Bool{
        for el in chosenFriends{
            if el[0] == element[0] && el[1] == element[1]{
                return true
            }
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("Clicked a cell")
        // pass any object as parameter, i.e. the tapped row
//        performSegue(withIdentifier: "ShowReceivedSegue", sender: indexPath.row)
        //here we want to save this friend to a list of those people we are going to ask later
        if let cell = self.tableView(tableView, cellForRowAt: indexPath) as? UITableViewCell{
            
            let val = friendList[indexPath.row]
            if contains(element: val){
//                print("Contains ", val, ": ", chosenFriends)
                removeSpecific(element: val)
//                print("Removed it")
//              tableView.deselectRow(at: indexPath, animated: true)
                cell.accessoryType = .none
            }
            else{
//                print("Does not contain ", val, ": ", chosenFriends)
                chosenFriends.append(val)
//                print("Now it does: ", chosenFriends)
                cell.accessoryType = .checkmark
                
            }
        }
        if chosenFriends.count == 0{
            selectedOutputLabel.text = "None Selected"
        }
        else{
            var s = chosenFriends[0][0]
            for var i in 1..<chosenFriends.count {
                s += ", " + chosenFriends[i][0]
            }
            selectedOutputLabel.text = s
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //moves
    @IBAction func moveToPingPage(_ sender: UIButton) {
        if chosenFriends.count > 0, let dst = self.dest{
            print("Performing Segue")
            performSegue(withIdentifier: "goToPingSegue", sender: self)
        }
        else{
            let alertController = UIAlertController(title: "Invalid Selection", message:
                "You Must Select a Friend and a Destination!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            //output alert
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PingingScreenController,
            segue.identifier == "goToPingSegue"
        {
            destination.friendsToPing = chosenFriends
            destination.time = timePicked
            destination.dest = self.dest!
            //and transfer location as well and travel destination
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


    // Handle the user's selection.
    extension SendRequestController: GMSAutocompleteResultsViewControllerDelegate {
        func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                               didAutocompleteWith place: GMSPlace) {
            searchController?.isActive = false
            // Do something with the selected place.
            self.dest = place
        }
        
        func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                               didFailAutocompleteWithError error: Error){
            // TODO: handle the error.
            print("Error")
        }
        
        // Turn the network activity indicator on and off again.
        func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    
    
    
    
    
    
    
    
    

    
