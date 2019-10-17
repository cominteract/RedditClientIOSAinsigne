//
//  RedditAuthSignPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditAuthSignView protocol for updating the view in the view controllers
protocol RedditAuthSignView: class {
    /// authTokenUpdateView when retrieving token is successful update the view
    func authTokenUpdateView()
    /// authTokenErrorView when retrieving token fails update the view
    func authTokenErrorUpdateView()
}

/// RedditAuthSignDelegate protocol for delegating implementations from the RedditAuthSignServices
protocol RedditAuthSignDelegate: class{
    /// authTokenReceived when token is retrieved delegate the token as input
    ///
    /// - Parameter token: as String the accesstoken
    func authTokenReceived(token : String)
    
    /// authTokenError when token retrieval fails delegate the error found
    ///
    /// - Parameter error: as Error the error
    func authTokenError(error : Error)
}

/// RedditAuthSignPresenter protocol for implementing the RedditAuthSignPresenter
protocol RedditAuthSignPresenter {
    /// starts the auth process using Oauth
    func startAuth()
}

/// RedditAuthSignPresenter implementation based on the presenter protocol
class RedditAuthSignPresenterImplementation : RedditAuthSignPresenter, RedditAuthSignDelegate {
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

    /// RedditAuthSignView reference of the RedditAuthSignViewController as RedditAuthSignView type. Must be weak
    fileprivate weak var view: RedditAuthSignView?
    
    /// RedditAuthSignServices property to set the services used by the presenter
    var service : RedditAuthSignServices!
    
    /// initializes with the RedditAuthSignViewController as the RedditAuthSignView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditAuthSignViewController as the RedditAuthSignView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditAuthSignView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditAuthSignServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
