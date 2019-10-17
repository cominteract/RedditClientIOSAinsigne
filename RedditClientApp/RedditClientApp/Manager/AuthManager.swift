//
//  AuthManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// TokenRetrieve class implementing the ErrorAuth which is the parent class to return the error from the auth through closure callback and the closure to return the token retrieved
class TokenRetrieve : ErrorAuth{
    var didRetrieveToken : ((TokenResponse) -> ())?
    
}

/// ErrorAuth which is the parent class to return the error from the auth through closure callback
class ErrorAuth{
    var didEncounterError : ((Error, Bool) -> ())?
}
class AuthManager: AuthProtocol {

    /// startAuth starts the authentication process using a callback whether mock or from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether authentication is successful as TokenRetrieve
    func startAuth(authRetrieve : TokenRetrieve)
    {
        
    }
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    {
        return false
    }
    
    /// refreshAuth refreshes the token using a callback whether mock or from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether refreshing the authentication is successful as TokenRetrieve
    func refreshAuth(authRetrieve : TokenRetrieve)
    {
        
    }
 
}
