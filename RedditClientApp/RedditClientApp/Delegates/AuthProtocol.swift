//
//  AuthTokenDelegate.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


/// AuthProtocol which is the template used in authentication implementations with the mock auth manager or the reddit oauth manager
protocol AuthProtocol : class {
    
    /// startAuth starts the authentication process using a callback whether mock or from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether authentication is successful as TokenRetrieve
    func startAuth(authRetrieve : TokenRetrieve)
    
    
    /// refreshAuth refreshes the token using a callback whether mock or from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether refreshing the authentication is successful as TokenRetrieve

    func refreshAuth(authRetrieve : TokenRetrieve)
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
}
