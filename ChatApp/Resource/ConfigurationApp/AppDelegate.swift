//
//  AppDelegate.swift
//  ChatApp
//
//  Created by ModyMayaAser on 24/02/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let defaults = UserDefaults.standard
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().tintColor = .black
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if (defaults.object(forKey: "user") as? Data) != nil {
            window?.rootViewController = UINavigationController(rootViewController: FrindesView())
        }else {
            window?.rootViewController = UINavigationController(rootViewController: LoginView())
        }
        window?.makeKeyAndVisible()
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if (defaults.object(forKey: "user") as? Data) != nil {
            publicSocketManager.default.connectSocket { (success) in
                print("Socket Connection : \(success)")
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if (defaults.object(forKey: "user") as? Data) != nil {
            publicSocketManager.default.disconnectSocket()
        }
    }
    

}

