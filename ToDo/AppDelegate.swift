//
//  AppDelegate.swift
//  ToDo
//
//  Created by Catherine Chan on 4/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Option 4: let the initialization here just to catch if there is any initialisation error. becasue we are not using realm in this file, can use _ to replace 'realm' and delete key word let
        
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        }
        catch {
            print("Error initialising new realm: \(error)")
        }
        
//       print(Realm.Configuration.defaultConfiguration.fileURL) // where the Realm data is stored
        
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String) // This is to show where the path our data is stored
        
        return true
    }
    //Option 3: CoreData
//    func applicationWillTerminate(_ application: UIApplication) {
//
//        self.saveContext()
//    }
//
//
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel") // we set this with the name of our Data Model, these two has to match so that the behind the scene set up and the relaship can be created properly
//
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? { // load the Persistent Store, info and log if there is any errors
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container // if there is no error, we are going to return the value of the container to the lazy variable. And we are able to access it from other classes
//    }()
//
    // Option 3 MARK: - Core Data Saving support
    
//    func saveContext () { // context is a area you can change and update your data, so that you can undo and redo until your are happy with the data, then you can save the data from this temporary area to the container for permananet storage
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
}





