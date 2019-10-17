//
//  ClosureResults.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class ClosureResults: NSObject {
    
    /// apiResults consolidates the endpoints to return what type of closure they would need for the response
    ///
    /// - Parameters:
    ///   - apiEndpoint: as APIEndpoint the endpoint for the closure callback to be used
    ///   - data: as Data the response in data form to be decoded
    ///   - retrieved: as ErrorRetrieved the parent class to be downcasted for returning the results through callbacks
    static func apiResults(apiEndpoint : APIEndpoint, data : Data, retrieved : ErrorRetrieved)
    {
        let decoder = JSONDecoder()
        switch apiEndpoint { case .News,.Home,.Popular, .Trending, .SubredditCollections, .MineSubreddit, .SubByTopic, .SrNames, .Notifications, .MsgInbox, .SubredditPosts,.SubPopular,.SubNew, .UserOverview, .Best, .TrendingSub, .Default, .UserPopular, .Input,.SubredditInfo, .SubAll:
            do {
                let value = try decoder.decode(FeedListing.self, from: data)
                (retrieved as! ListingRetrieved).didRetrievedListing!(value, apiEndpoint)
            }
            catch let err {
                (retrieved as! ListingRetrieved).didRetrievedError!(err,false)
            }
        case .AbtSub:
            do {
                let value = try decoder.decode(Subreddit.self, from: data)
                (retrieved as! SubredditRetrieved).didRetrievedSubreddit!(value, apiEndpoint)
            }
            catch let err {
                (retrieved as! SubredditRetrieved).didRetrievedError!(err,false)
            }
        case .ArticleComments:
            do {
                let value = try decoder.decode([Comments].self, from: data)
                (retrieved as!  CommentsRetrieved).didRetrievedComments!(value, apiEndpoint)
            }
            catch let err {
                (retrieved as! CommentsRetrieved).didRetrievedError!(err,false)
            }
        case .SubmitLink:
            if let val = String(data: data, encoding: .utf8), val.contains("\"name\":"), val.contains("\"data\":") , val.contains("\"id\":")
            { 
                let dict = val.toDict(text: val)
                if let json = dict?["json"] as? [String : Any?],
                let ddata = json["data"] as? [String : Any?], let url = ddata["url"] as? String
                {
                    (retrieved as! PostSuccess).didRetrievedPost!("You can see the post in \(url)", apiEndpoint)
                }
                else
                {
                    (retrieved as! PostSuccess).didRetrievedError!(ErrorCases.postError(),false)
                }
            }
        case .AbtSubRules:
            do {
                let value = try decoder.decode(Rules.self, from: data)
                (retrieved as! RulesRetrieved).didRetrievedRules!(value, apiEndpoint)
            }
            catch let err {
                (retrieved as! RulesRetrieved).didRetrievedError!(err,false)
            }
        case  .SearchSub:
            do {
                let value = try decoder.decode(SearchSubreddit.self, from: data)
                (retrieved as! SubredditSearched).didRetrievedSearchedSub!(value, apiEndpoint)
            }
            catch let err {
                (retrieved as! SubredditSearched).didRetrievedError!(err,false)
            }
        default:
            do {
                let value = try decoder.decode(Me.self, from: data)
                (retrieved as! MeRetrieved).didRetrievedMe!(value)
            }
            catch let err {
                (retrieved as! MeRetrieved).didRetrievedError!(err,false)
            }
        }
    }
    
}
