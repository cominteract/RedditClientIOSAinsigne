//
//  RedditInboxServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditInboxServices class for implementing the services needed for the presenter
class RedditInboxServices: NSObject {

    /// delegate for the implementation of the template generated RedditInboxServices
    weak var delegate : RedditInboxDelegate?
    
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
    
    /// filterInbox filter the Listing through whether it is an inbox or not
    ///
    /// - Parameter children: as FeedChildrenListing? the listing to filter to
    /// - Returns: as Bool whether current listing is an inbox or not
    func filterInbox(children : FeedChildrenListing?) -> Bool
    {
        if let children = children, let wascomment = children.data?.was_comment,
            wascomment
        {
            return true
        }
        return false
    }
    
    /// filterActivity filter the Listing through whether it is an activity or not
    ///
    /// - Parameter children: as FeedChildrenListing? the listing to filter to
    /// - Returns: as Bool whether current listing is an activity or not
    func filterActivity(children : FeedChildrenListing?) -> Bool
    {
        if let children = children, let wascomment = children.data?.was_comment,
            wascomment
        {
            return false
        }
        return true
    }
    
    /// startListing starts the api process to retrieve the msginbox and overview endpoints for the listings using the ListingRetrieved closure callback
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
                self.delegate?.retrievedInbox(listing:  inbox   )
                self.delegate?.retrievedOverview(listing:  activity )
                Config.updateRefreshedInbox(value: "Yes")
            }
        }
        retrieved.didRetrievedError = {
            (error : Error, revoked : Bool) in
            print("Message \(error.localizedDescription)")
            self.delegate?.retrievedOverviewError(error: error)
            
        }
        Config.updateRefreshedInbox(value: "Not")
        if let username = Config.getUser(){
            //self.apiManager.startAPI(endPoint: APIEndpoint.UserOverview, input: username, isJson: false, retrieved: retrieved)
            self.apiManager.startAPI(endPoint: APIEndpoint.MsgInbox, input: username, isJson: false, retrieved: retrieved)
        }
    }
}
