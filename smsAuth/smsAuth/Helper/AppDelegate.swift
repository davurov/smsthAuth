//
//  AppDelegate.swift
//  smsAuth
//
//  Created by Abduraxmon on 02/03/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow()
        
        if Auth.auth().currentUser == nil {
            let phoneVC = PhoneVC(nibName: "PhoneVC", bundle: nil)
            window?.rootViewController = phoneVC
            window?.makeKeyAndVisible()
        } else {
            let accountController = AccountController(nibName: "AccountController", bundle: nil)
            let item = UITabBarItem()
            item.title = "Home"
            item.image = UIImage(systemName: "house.fill")
            accountController.tabBarItem = item
            let tabBarController = UITabBarController()
            tabBarController.tabBar.tintColor = .white
            tabBarController.tabBar.backgroundColor = .black
            
            tabBarController.viewControllers = [accountController]
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    
}


