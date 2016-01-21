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
	var coreDataController: CoreDataController!
	var sfFilmMediator: SFFilmMediator?
	var allFilmsModel: AllFilmsModel?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		coreDataController = CoreDataController()
		if let navigationController = window?.rootViewController as? UINavigationController,
			let filmsTableViewController = navigationController.viewControllers.first as? FilmsTableViewController {
				allFilmsModel = AllFilmsModel(managedObjectContext: coreDataController.managedObjectContext)
				filmsTableViewController.viewModel = allFilmsModel
		}
		
		sfFilmMediator = SFFilmMediator(managedObjectContext: coreDataController.managedObjectContext)
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

