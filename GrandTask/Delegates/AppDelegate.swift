//
//  AppDelegate.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import UIKit
import CoreData
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability: Reachability!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupReachability()
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
    
    fileprivate func setupReachability() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                                         name: Notification.Name.reachabilityChanged,
                                                         object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("This is not working.")
        }
    }
    @objc func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.connection == .wifi {
            print("Reachable via WiFi")
            Helper.SaveCheckNetwork(check: "Online")
        } else if reachability.connection == .cellular {
            print("Reachable via Cellular")
            Helper.SaveCheckNetwork(check: "Online")
        }else{
            print("Not reachable")
            Helper.SaveCheckNetwork(check: "Offline")
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("OfflineListen"), object: nil , userInfo: [:])
        }
    }
    
    // MARK: Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OfflineMatchesModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()


}

