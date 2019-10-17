//
//  RedditChatServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation




// TODO : UNUSED because the api for chat isn't available yet
/// RedditChatServices class for implementing the services needed for the presenter
class RedditChatServices: NSObject {

    /// delegate for the implementation of the template generated RedditChatServices
    weak var delegate : RedditChatDelegate?
    
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
    
    func filterInbox(children : FeedChildrenListing?) -> Bool
    {
        if let children = children, let wascomment = children.data?.was_comment,
            wascomment
        {
            return true
        }
        return false
    }
    func filterActivity(children : FeedChildrenListing?) -> Bool
    {
        if let children = children, let wascomment = children.data?.was_comment,
            wascomment
        {
            return false
        }
        return true
    }
    
    func startListing()
    {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = {
            (list : FeedListing, endPoint : APIEndpoint) in
            print("Activity listing \(list.data?.children?.count)")
            if endPoint == APIEndpoint.MsgInbox, let children = list.data?.children
            {
                let activity = children.filter({
                    self.filterInbox(children: $0)
                })
                let inbox =
                    children.filter({
                        self.filterActivity(children: $0)
                    })
                
            }
            
            
        }
        retrieved.didRetrievedError = {
            (error : Error, revoked : Bool) in
            print("Message \(error.localizedDescription)")
            
        }
        if let username = Config.getUser(){
            //self.apiManager.startAPI(endPoint: APIEndpoint.UserOverview, input: username, isJson: false, retrieved: retrieved)
            self.apiManager.startAPI(endPoint: APIEndpoint.MsgWhere, input: username, isJson: false, retrieved: retrieved)
        }
    }
    
}
