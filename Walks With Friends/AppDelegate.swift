//
//  AppDelegate.swift
//  Walks With Friends
//
//  Created by Suneel Belkhale on 11/12/16.
//  Copyright © 2016 Cheney 8. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        //let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        // iOS 10 support
       
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
    GMSServices.provideAPIKey("AIzaSyBGi1UBs07wTrvUJcv0lJqwvku8zNcwJwI");
    GMSPlacesClient.provideAPIKey("AIzaSyBGi1UBs07wTrvUJcv0lJqwvku8zNcwJwI")
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("\n \n \n \n APNs device token: \(deviceTokenString) \n \n \n \n")
        
        // Persist it in your backend in case it's new
    }
    
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    
    func application(_ application: UIApplication,
                              didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                              fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if (userInfo["AcceptingInvite"] != nil) {
            /*self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            self.window?.rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "WaitingScreen")
            self.window?.makeKeyAndVisible()*/
            
            
            /*let controller = storyboard?.instantiateViewControllerWithIdentifier("Second") as SecondViewController
            presentViewController(controller, animated: true, completion: nil)*/
            
            //present(UIViewController, animated: Bool, completion: (() -> Void)? = nil)
            let refreshAlert = UIAlertController(title: "Go to the Waiting Screen", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                //{ (action: UIAlertAction!) in
//                guard let vc = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier:"WaitingScreenController")
//                    else{
//                        print("BAD")
//                        return
//                }
//                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
//            }))
            
            self.window?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
            
    

        }
    }
    
    /*func catchIt(userInfo: NSNotification){
        var not = JSON(userInfo.valueForKey("userInfo")!)
        // Check nil and do redirect here, for example:
        if not["callback"]["type"].int == 10{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc1: example1VC = storyboard.instantiateViewControllerWithIdentifier("example1") as! example1VC
            self.navigationController?.pushViewController(vc1, animated: true)
        }
        else if not["callback"]["type"].int == 20{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc2: example2VC = storyboard.instantiateViewControllerWithIdentifier("example2") as! example2VC
            self.navigationController?.pushViewController(vc2, animated: true)
        }*/
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

