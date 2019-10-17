//
//  APIManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// error retrieved which is the parent class to return the error from the fetch query through closure callback
class ErrorRetrieved{
    var didRetrievedError : ((Error, Bool) -> Void)?
}

/// listing retrieved which implements error retrieved to return the error from the fetch query through closure callback
class ListingRetrieved : ErrorRetrieved{
    var didRetrievedListing: ((FeedListing, APIEndpoint) -> Void)?
}

/// comments retrieved which implements error retrieved to return the error from the fetch query through closure callback
class CommentsRetrieved : ErrorRetrieved{
    var didRetrievedComments: (([Comments], APIEndpoint) -> Void)?
}

/// rules retrieved which implements error retrieved to return the error from the fetch query through closure callback
class RulesRetrieved : ErrorRetrieved{
    var didRetrievedRules: ((Rules, APIEndpoint) -> Void)?
}

/// subreddit searched which implements error retrieved to return the error from the fetch query through closure callback
class SubredditSearched : ErrorRetrieved{
    var didRetrievedSearchedSub: ((SearchSubreddit, APIEndpoint) -> Void)?
}


/// subreddit retrieved which implements error retrieved to return the error from the fetch query through closure callback
class SubredditRetrieved : ErrorRetrieved{
    var didRetrievedSubreddit: ((Subreddit, APIEndpoint) -> Void)?
}


/// post success which implements error retrieved to return the error from the post request through closure callback
class PostSuccess : ErrorRetrieved{
    var didRetrievedPost: ((String, APIEndpoint) -> Void)?
}


/// me info retrieved which implements error retrieved to return the error from the fetch query through closure callback
class MeRetrieved : ErrorRetrieved{
    var didRetrievedMe : ((Me) -> Void)?
}

class APIManager: APIProtocol {
  
    var postType = PostType.Text
//    /// trending subreddits retrieved which is the parent class to return the error from the fetch query through closure callback
//    class ErrorRetrieved{
//        var didRetrievedError : ((Error, Bool) -> Void)?
//    }
    
    func appendFile(body : Data)
    {
        
    }
    
    func startAPI(endPoint : APIEndpoint, input : String?, isJson : Bool, retrieved : ErrorRetrieved)
    {
        
    }
    
}
