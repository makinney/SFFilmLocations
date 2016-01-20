//
//  AppDelegate.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let coreDataStack = CoreDataStack()
	var sfFilmMediator: SFFilmMediator?
	var allFilmsModel: AllFilmsModel?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		if let FilmsTableViewController = window?.rootViewController as? FilmsTableViewController {
			allFilmsModel = AllFilmsModel(managedObjectContext: coreDataStack.managedObjectContext!)
			FilmsTableViewController.viewModel = allFilmsModel
		}
		sfFilmMediator = SFFilmMediator(coreDataStack: coreDataStack)
		sfFilmMediator!.loadFilmData()
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
	}

	func applicationDidEnterBackground(application: UIApplication) {
	}

	func applicationWillEnterForeground(application: UIApplication) {
	}

	func applicationDidBecomeActive(application: UIApplication) {
	}

	func applicationWillTerminate(application: UIApplication) {
	}
}

