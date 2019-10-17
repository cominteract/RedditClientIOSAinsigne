//
//  ServicesInjector.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


/// Injects the type of services depending on the target selected
class ServicesInjector: NSObject {
    #if DEV
        let auth = RedditAuthManager()
    #elseif PROD
        let auth = RedditAuthManager()
    #elseif MOCK
        let auth = MockAuthManager()
    #else
        let auth = RedditAuthManager()
    #endif
    
    #if DEV
        let manager = RedditAPIManager()
    #elseif PROD
        let manager = RedditAPIManager()
    #elseif MOCK
        let manager = MockAPIManager()
    #else
        let manager = RedditAPIManager()
    #endif
    
    var data : APIData?
    
    init(data : APIData) {
        self.data = data
    }
    func getAPI() -> APIManager
    {
        return manager
    }
    
    func getAuth() -> AuthManager
    {
        return auth
    }
}
