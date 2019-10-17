//
//  RedditOAuthServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditOAuthServices class for implementing the services needed for the presenter
class RedditOAuthServices: NSObject {

    /// delegate for the implementation of the template generated RedditOAuthServices
    weak var delegate : RedditOAuthDelegate?
    
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
    
    /// starts the auth process using Oauth using the TokenRetrieve closure callback and update the tokens in config also starts a refresh process when retried
    func startAuth()
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
            self.delegate?.authTokenReceived(token: token.access_token)
        }
        authRetrieve.didEncounterError = {
            (error : Error, revoked : Bool ) in
            self.delegate?.authTokenError(error: error)
        }
        if let token = Config.getOauthToken(), authManager.isLogged()
        {
            self.delegate?.authTokenReceived(token: token)
        }
        else if Config.getOauthToken() != nil && !authManager.isLogged()
        {
            authManager.refreshAuth(authRetrieve: authRetrieve)
        }
        else
        {
            authManager.startAuth(authRetrieve: authRetrieve)
        }
    }
 
    
}
