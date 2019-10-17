//
//  RedditFeedServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditFeedServices class for implementing the services needed for the presenter
class RedditFeedServices: NSObject {

    /// delegate for the implementation of the template generated RedditFeedServices
    weak var delegate : RedditFeedDelegate?
    
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
    
    /// manageHomeFeed appends the children so they can be displayed as merge of all the subreddits subscribed
    ///
    /// - Parameters:
    ///   - feeds: as [FeedListing] children to append with
    func manageHomeFeed(feeds : [FeedListing], dele : RedditFeedDelegate?)
    {
        var feedListing = FeedListing(kind : "", data : nil)
        for feed in feeds
        {
            if let children = feed.data?.children, children.count > 0
            {
                var count = 5
                if children.count < 5
                {
                    count = children.count - 1
                }
                if feedListing.data == nil
                {
                    feedListing.data = FeedDataListing(children : [FeedChildrenListing](children.prefix(count)))
                }
                else
                {
                    feedListing.data?.children?.append(contentsOf: children.prefix(count))
                }
            }
        }
        dele?.retrievedHome(listing: feedListing)
    }
    
    /// as the error closure callback for the retrieved
    ///
    /// - Returns: as Error closure
    func error() ->  ((Error, Bool) -> Void)?
    {
        return {
            (error : Error, revoked : Bool) in
            print("Listing \(error.localizedDescription)")
        }
    }
    
    /// startLListing starts the api process to retrieve the home, popular, news feed, subreddits subscribed using the ListingRetrieved closure callback and the MeRetrieved to save the user info
    func startListing()
    {
        var feedsCount = 0
        var feeds = [FeedListing]()
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = { [weak self]
            (list : FeedListing, endPoint : APIEndpoint) in
            print("Listing \(list.data?.children?.count) \(endPoint)")
            if endPoint == APIEndpoint.News{
                self?.delegate?.retrievedNews(listing: list)
            }
            else if endPoint == APIEndpoint.MineSubreddit, let children = list.data?.children {
                for child in children
                {
                    if let name = child.data?.display_name_prefixed
                    {
                        self?.apiManager.startAPI(endPoint: APIEndpoint.Input, input:name , isJson: false, retrieved: retrieved)
                    }
                }
                feedsCount = children.count
            }
            else if endPoint == APIEndpoint.Input
            {
                print("Start \(list.data?.children?.count)")
                feeds.append(list)
                if feedsCount == feeds.count
                {
                    Config.updateRefreshed(value: "Yes")
                    self?.manageHomeFeed(feeds: feeds, dele: self?.delegate)
                }
            }
            else if endPoint == APIEndpoint.Trending{
                self?.delegate?.retrievedTrending(listing: list)
            }
            else if endPoint == APIEndpoint.Popular {
                self?.delegate?.retrievedPopular(listing: list)
            }
            else {
                self?.delegate?.retrievedHome(listing: list)
            }
        }
        retrieved.didRetrievedError = error()
        if authManager.isLogged()
        {
            apiManager.startAPI(endPoint: APIEndpoint.MineSubreddit, input:nil , isJson: false, retrieved: retrieved)
        }
        else
        {
            Config.updateRefreshed(value: "Not")
            apiManager.startAPI(endPoint: APIEndpoint.Home , input:EndPoints.endpoint(endpoint: APIEndpoint.Best, input: nil)  , isJson: true, retrieved: retrieved)
        }
        apiManager.startAPI(endPoint: APIEndpoint.Popular, input: EndPoints.endpoint(endpoint: APIEndpoint.Hot, input: nil) , isJson: true, retrieved: retrieved)
        apiManager.startAPI(endPoint: APIEndpoint.News, input: EndPoints.endpoint(endpoint: APIEndpoint.Hot, input: nil) , isJson: true, retrieved: retrieved)
//        apiManager.startAPI(endPoint: APIEndpoint.Default, input: EndPoints.endpoint(endpoint: APIEndpoint.Best, input: nil) , isJson: true, retrieved: retrieved)
        apiManager.startAPI(endPoint: APIEndpoint.Trending, input: EndPoints.endpoint(endpoint: APIEndpoint.Hot, input: nil) , isJson: true, retrieved: retrieved)
        if authManager.isLogged()
        {
            let meretrieved = MeRetrieved()
            meretrieved.didRetrievedMe = {
                (me : Me) in
                if let username = me.name
                {
                    Config.updateUser(value: username)
                }
            }
            meretrieved.didRetrievedError = error()
            apiManager.startAPI(endPoint: APIEndpoint.Me, input:nil, isJson: false, retrieved: meretrieved)
        }
    }
    
    /// starts the api to search subreddits using the SubredditSearched closure callback to identify whether search is successful
    ///
    /// - Parameter input: as String the query to be searched
    func startSearch(input : String)
    {
        let retrieved = SubredditSearched()
        retrieved.didRetrievedSearchedSub = { [weak self]
            (searched : SearchSubreddit, endPoint : APIEndpoint) in
            self?.delegate?.retrieveSearched(searched: searched)
        }
        retrieved.didRetrievedError = error()
        apiManager.startAPI(endPoint: APIEndpoint.SearchSub, input:input, isJson: false, retrieved: retrieved)
    }
    
    
    /// refresh the home page when logged out
    func refreshLoggedOut()
    {
        if Config.getOauthToken() != nil && authManager.isLogged()
        {
            startListing()
        }
    }
}
