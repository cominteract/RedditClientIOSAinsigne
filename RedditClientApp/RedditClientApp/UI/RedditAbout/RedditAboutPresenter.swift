//
//  RedditAboutPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditAboutView protocol for updating the view in the view controllers
protocol RedditAboutView: class {
    
    /// retrievedMeUpdateView after retrieving the Me response update the view
    ///
    /// - Parameter me: as Me info about the current user
    func retrievedMeUpdateView(me : Me)
}

/// RedditAboutDelegate protocol for delegating implementations from the RedditAboutServices
protocol RedditAboutDelegate: class{
    /// retrievedMe after retrieving the Me response
    ///
    /// - Parameter me: as Me info about the current user
    func retrievedMe(me : Me)
}

/// RedditAboutPresenter protocol for implementing the RedditAboutPresenter
protocol RedditAboutPresenter {
    
    
    /// starts the api through the presenter
    ///
    /// - Parameter user: as String the current id to be used to get the info
    func startAPI(user : String)
}

/// RedditAboutPresenter implementation based on the presenter protocol
class RedditAboutPresenterImplementation : RedditAboutPresenter, RedditAboutDelegate {
    
    /// starts the api through the presenter
    ///
    /// - Parameter user: as String the current id to be used to get the info
    func startAPI(user: String) {
        service.startInfo(user: user)
    }
    
    /// retrievedMeUpdateView after retrieving the Me response
    ///
    /// - Parameter me: as Me info about the current user
    func retrievedMe(me: Me) {
        view?.retrievedMeUpdateView(me: me)
    }

    /// RedditAboutView reference of the RedditAboutViewController as RedditAboutView type. Must be weak
    fileprivate weak var view: RedditAboutView?
    
    /// RedditAboutServices property to set the services used by the presenter
    var service : RedditAboutServices!
    
    /// initializes with the RedditAboutViewController as the RedditAboutView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditAboutViewController as the RedditAboutView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditAboutView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditAboutServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
