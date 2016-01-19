//
//  CoreDataStack.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack {
	
	init() {
		
	}
	
	public class var sharedInstance: CoreDataStack {
		struct Singleton {
			static let instance = CoreDataStack()
		}
		return Singleton.instance
	}
	
	public func saveContext () ->  Bool {
		var success = true
		if let moc = self.managedObjectContext {
			if moc.hasChanges {
				do {
					try moc.save()
				} catch  {
					success = false
				}
			}
		}
		return success
	}
	
	lazy var applicationDocumentsDirectory: NSURL = {
		// The directory the application uses to store the Core Data store file. This code uses a directory named "com.mkinney.City_Art_San_Francisco" in the application's documents Application Support directory.
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.count-1]
	}()
	
	lazy var managedObjectModel: NSManagedObjectModel = {
		// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
		let modelURL = NSBundle.mainBundle().URLForResource("SFFilmLocations", withExtension:
		"momd")!
		return NSManagedObjectModel(contentsOfURL: modelURL)!
	}()
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
		// The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
		
		//		self.updateStoredSqliteFromBundle() // maximum one time per app update
		
		// Create the coordinator and store
		var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
	 let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
		
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
		} catch let error as NSError {
			NSLog("Unresolved error \(error), \(error.userInfo)")
			//		abort() // TODO:
		} catch {
			fatalError()
		}
		
		return coordinator
	}()
	
	lazy var managedObjectContext: NSManagedObjectContext? = {
		// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
		let coordinator = self.persistentStoreCoordinator
		if coordinator == nil {
			return nil
		}
		
		var managedObjectContext = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator
		return managedObjectContext
	}()
	
}
