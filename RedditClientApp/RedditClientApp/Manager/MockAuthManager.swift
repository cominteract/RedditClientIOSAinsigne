//
//  MockAuthManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class MockAuthManager: AuthManager {

    
    /// startAuth starts the authentication process using a callback from mock
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether authentication is successful as TokenRetrieve
    override func startAuth(authRetrieve : TokenRetrieve) {
        //Config.appDelegate.tokenRetrieve = authRetrieve
    }
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    override func isLogged() -> Bool
    {
        return false
    }
    
    /// refreshAuth refreshes the token using a callback from mock
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether refreshing the authentication is successful as TokenRetrieve
    override func refreshAuth(authRetrieve : TokenRetrieve)
    {
        
    }
}
