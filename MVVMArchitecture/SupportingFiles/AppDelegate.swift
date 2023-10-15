//
//  AppDelegate.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createCopyOfDatabaseIfNeeded()
        return true
    }
    
    func createCopyOfDatabaseIfNeeded() {
        var success: Bool
        let fileManager = FileManager.default
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)
        let documentsDirectory = paths[0]
        let appDBPath = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("db.sqlite").path
        success = fileManager.fileExists(atPath: appDBPath)
        if success {
            return
        }
        let defaultDBPath = URL(fileURLWithPath: Bundle.main.resourcePath ?? "").appendingPathComponent("db.sqlite").path
        do {
            try fileManager.copyItem(atPath: defaultDBPath, toPath: appDBPath)
            success = true
            print("Successed")
        } catch {
            print("Error while copying db: ",error)
        }
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentCloudKitContainer(name: "EmpCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        let empEntity = NSEntityDescription.entity(forEntityName: "Employee", in: context)!
        for i in 1...5{
            let user = NSManagedObject(entity: empEntity, insertInto: context)
            user.setValue("Tejas - \(i)", forKey: "name")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func retriveContext() -> [NSFetchRequestResult]?{
        let contex = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        do{
            let result = try contex.fetch(fetchRequest)
            return result
        }catch{
            print("Error while fetching data")
        }
        return nil
    }
}
