//
//  AppDelegate.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 01.03.2022.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Enable IQKeyboard
        IQKeyboardManager.shared.enable = true
        
        // Enable Firebase
        FirebaseApp.configure()
        
        // Enable persistent container Core data
        lazy var persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "BigDeal")
                container.loadPersistentStores { description, error in
                    if let error = error {
                        fatalError("Unable to load persistent stores: \(error)")
                    }
                }
                return container
            }()
        
        return true
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
}
