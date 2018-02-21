//
//  AppDelegate.swift
//  navigatAR
//
//  Created by Michael Gira on 2/1/18.
//  Copyright © 2018 MICDS Programming. All rights reserved.
//

import UIKit
import Firebase
import IndoorAtlas
import GoogleMaps

func getConfigItem(name: String) -> String? {
	let filePath = Bundle.main.path(forResource: "config", ofType: "plist")
	let plist = NSDictionary(contentsOfFile: filePath!)
	if let value = plist!.object(forKey: name) as? String {
		return value
	} else {
		return nil
	}
}

extension FloatingPoint {
	var degreesToRadians: Self { return self * .pi / 180 }
	var radiansToDegrees: Self { return self * 180 / .pi }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	var locationManager: IALocationManager?
	
	func authenticateAndRequestLocation() {
		
		// Get IALocationManager shared instance and point delegate to receiver
		locationManager = IALocationManager.sharedInstance()
		
		// Set IndoorAtlas API key and secret
		let IAAPIKeyId = getConfigItem(name: "IAAPIKeyId")!
		let IAAPIKeySecret = getConfigItem(name: "IAAPIKeySecret")!
		locationManager!.setApiKey(IAAPIKeyId, andSecret: IAAPIKeySecret)
		
		// Request location updates
		locationManager!.startUpdatingLocation()
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FirebaseApp.configure()
		authenticateAndRequestLocation()
		
		let GMSAPIKey = getConfigItem(name: "GMSAPIKey")
		GMSServices.provideAPIKey(GMSAPIKey!)
		return true
	}

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
