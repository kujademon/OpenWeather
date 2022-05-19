//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = MainVC()
        let nvc = UINavigationController(rootViewController: mainViewController)
        window!.rootViewController = nvc
        window!.makeKeyAndVisible()
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            let navBar = UINavigationBar()
            appearance.configureWithOpaqueBackground()
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBar.standardAppearance
            UINavigationBar.appearance().standardAppearance = navBar.standardAppearance
            UINavigationBar.appearance().isTranslucent = false
        } else {
            // Fallback on earlier versions
            UINavigationBar.appearance().isTranslucent = false
        }
        //Hide Keyboard
        IQKeyboardManager.shared.enable = true
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

