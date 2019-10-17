//
//  AppDelegate.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var tokenRetrieve : TokenRetrieve?
    
    var mainVC : RedditMainViewController?
    
    var introVC : RedditOAuthViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initVC()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// using the token retrieve delegate this allows passing the code to be used
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let scheme = url.scheme, scheme == "rditai", let queryParams = url.query?.components(separatedBy: "&")
        {
            var codeParam = queryParams.filter( {
                $0.contains("code=")
            })
            let codeQuery: String = codeParam[0]
            var code: String = codeQuery.replacingOccurrences(of: "code=", with: "")
            if let auth = tokenRetrieve
            {
                Config.getToken(code: code, auth: auth)
            }
            return true
        }
        return false
    }
    
    /// using the token retrieve delegate this allows passing the code to be used
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme == "rditai", let queryParams = url.query?.components(separatedBy: "&")
        {
            var codeParam = queryParams.filter( {
                $0.contains("code=")
            })
            let codeQuery: String = codeParam[0]
            var code: String = codeQuery.replacingOccurrences(of: "code=", with: "")
            if let auth = tokenRetrieve
            {
                Config.getToken(code: code, auth: auth)
            }
            print("My code is \(code)")
            return true
        }
        return false
    }

    /// initializes the initial root view controller
    func initVC()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        mainVC = storyboard.instantiateViewController(withIdentifier: "RedditMainViewController") as! RedditMainViewController
        introVC = storyboard.instantiateViewController(withIdentifier: "RedditOAuthViewController") as! RedditOAuthViewController
        
    }
    
    /// opens the intro controller for reddit client
    func openIntro()
    {
        DispatchQueue.main.async {  [weak self] in
            if self?.window?.rootViewController != self?.introVC
            {
                self?.window?.rootViewController = self?.introVC
            }
        }
    }
    
    /// opens the main controller for reddit client sets the selected to home
    func openMain()
    {
        
        DispatchQueue.main.async {  [weak self] in
            if self?.window?.rootViewController != self?.mainVC
            {
                self?.window?.rootViewController = self?.mainVC
                self?.mainVC?.selectedIndex = 0
            }
        }
    }

}

