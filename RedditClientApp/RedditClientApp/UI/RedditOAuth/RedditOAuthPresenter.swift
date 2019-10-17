//
//  RedditOAuthPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditOAuthView protocol for updating the view in the view controllers
protocol RedditOAuthView: class {
    
    /// authTokenUpdateView when retrieving token is successful update the view
    func authTokenUpdateView()
    /// authTokenErrorView when retrieving token fails update the view
    func authTokenErrorUpdateView()
}

/// RedditOAuthDelegate protocol for delegating implementations from the RedditOAuthServices
protocol RedditOAuthDelegate: class{
    
    /// authTokenReceived when token is retrieved delegate the token as input
    ///
    /// - Parameter token: as String the accesstoken
    func authTokenReceived(token : String)
    
    /// authTokenError when token retrieval fails delegate the error found
    ///
    /// - Parameter error: as Error the error
    func authTokenError(error : Error)
  
}

/// RedditOAuthPresenter protocol for implementing the RedditOAuthPresenter
protocol RedditOAuthPresenter {
    /// starts the auth process using Oauth
    func startAuth()
}

/// RedditOAuthPresenter implementation based on the presenter protocol
class RedditOAuthPresenterImplementation : RedditOAuthPresenter, RedditOAuthDelegate {
    
    /// authTokenReceived when token is retrieved delegate the token as input
    ///
    /// - Parameter token: as String the accesstoken
    func authTokenReceived(token: String) {
        view?.authTokenUpdateView()
    }
    
    /// authTokenError when token retrieval fails delegate the error found
    ///
    /// - Parameter error: as Error the error
    func authTokenError(error: Error) {
        view?.authTokenErrorUpdateView()
    }
    
    /// starts the auth process using Oauth
    func startAuth() {
        service.startAuth()
    }

    /// RedditOAuthView reference of the RedditOAuthViewController as RedditOAuthView type. Must be weak
    fileprivate weak var view: RedditOAuthView?
    
    /// RedditOAuthServices property to set the services used by the presenter
    var service : RedditOAuthServices!
    
    /// initializes with the RedditOAuthViewController as the RedditOAuthView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditOAuthViewController as the RedditOAuthView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditOAuthView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditOAuthServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
