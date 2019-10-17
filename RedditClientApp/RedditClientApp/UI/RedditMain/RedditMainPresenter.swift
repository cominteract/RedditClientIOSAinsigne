//
//  RedditMainPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditMainView protocol for updating the view in the view controllers
protocol RedditMainView: class {
  
}

/// RedditMainDelegate protocol for delegating implementations from the RedditMainServices
protocol RedditMainDelegate: class{
 
}

/// RedditMainPresenter protocol for implementing the RedditMainPresenter
protocol RedditMainPresenter {
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    
    /// refreshes the token when already logged
    func refreshToken()
}

/// RedditMainPresenter implementation based on the presenter protocol
class RedditMainPresenterImplementation : RedditMainPresenter, RedditMainDelegate {
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool {
       return service.isLogged()
    }
    
    /// refreshes the token when already logged
    func refreshToken() {
        service.refreshToken()
    }
    
    /// RedditMainView reference of the RedditMainViewController as RedditMainView type. Must be weak
    fileprivate weak var view: RedditMainView?
    
    /// RedditMainServices property to set the services used by the presenter
    var service : RedditMainServices!
    
    /// initializes with the RedditMainViewController as the RedditMainView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditMainViewController as the RedditMainView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditMainView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditMainServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
