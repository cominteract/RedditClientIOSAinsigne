//
//  RedditChatPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditChatView protocol for updating the view in the view controllers
protocol RedditChatView: class {
  
}

/// RedditChatDelegate protocol for delegating implementations from the RedditChatServices
protocol RedditChatDelegate: class{
    
}

/// RedditChatPresenter protocol for implementing the RedditChatPresenter
protocol RedditChatPresenter {

}
// TODO : UNUSED because the api for chat isn't available yet
/// RedditChatPresenter implementation based on the presenter protocol
class RedditChatPresenterImplementation : RedditChatPresenter, RedditChatDelegate {
    


    /// RedditChatView reference of the RedditChatViewController as RedditChatView type. Must be weak
    fileprivate weak var view: RedditChatView?
    
    /// RedditChatServices property to set the services used by the presenter
    var service : RedditChatServices!
    
    /// initializes with the RedditChatViewController as the RedditChatView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditChatViewController as the RedditChatView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditChatView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditChatServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
