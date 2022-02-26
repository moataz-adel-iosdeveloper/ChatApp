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

    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().tintColor = .black
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "user") as? Data) != nil {
            //let decoder = JSONDecoder()
            //if let student = try? decoder.decode(Student.self, from: studentData) {
                //print(student.name)
            //}
            window?.rootViewController = UINavigationController(rootViewController: FrindesView())
        }else {
            window?.rootViewController = UINavigationController(rootViewController: LoginView())
        }
        
        window?.makeKeyAndVisible()
        return true
    }


}

