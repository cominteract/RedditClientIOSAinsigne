//
//  RedditMainServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditMainServices class for implementing the services needed for the presenter
class RedditMainServices: NSObject {

    /// delegate for the implementation of the template generated RedditMainServices
    weak var delegate : RedditMainDelegate?
    
    /// apiManager used in consuming the api related to data whether mock or from aws to be initialized
    var apiManager : APIManager
    
    /// authManager used in consuming the authentication api whether mock or from aws to be initialized
    var authManager : AuthManager
    /// initializes with the apiManager used in consuming the api related to data whether mock or from aws and authManager used in consuming the authentication api whether mock or from aws
    ///
    /// - Parameters:
    ///   - apiManager: apiManager:  apiManager used in consuming the api related to data whether mock or from aws
    ///   - authManager: authManager:  authManager used in consuming the authentication api whether mock or from aws
    init(apiManager : APIManager, authManager : AuthManager) {
        self.apiManager = apiManager
        self.authManager = authManager
    }
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    {
        return authManager.isLogged()
    }
    
    /// refreshes the token when already logged
    func refreshToken()
    {
        let authRetrieve = TokenRetrieve()
        authRetrieve.didRetrieveToken = {
            (token : TokenResponse) in
            Config.updateToken(value: token.access_token)
            if let refToken = token.refresh_token
            {
                Config.updateRefreshToken(value: refToken)
            }
            let date = Date().addingTimeInterval(60.0 * 60.0)
            if let dateString = date.toString()
            {
                Config.updateRefreshDate(value: dateString)
            }
        }
        authRetrieve.didEncounterError = {
            (error : Error, revoked : Bool ) in
        }
        if Config.getOauthToken() != nil && !authManager.isLogged()
        {
            authManager.refreshAuth(authRetrieve: authRetrieve)
        }
    }
}
