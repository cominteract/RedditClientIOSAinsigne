//
//  RedditManagerTest.swift
//  RedditClientAppTests
//
//  Created by Andre Insigne on 17/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import XCTest

class RedditManagerTest: XCTestCase {
    let responses = Responses()
    let apiManager = MockAPIManager()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch()
    {
        let retrieved = SubredditSearched()
        retrieved.didRetrievedSearchedSub =
            { (sub : SearchSubreddit, endpoint : APIEndpoint) in
                XCTAssert(true)
        }
        retrieved.didRetrievedError = error()
        if let data = responses.searchsub().data(using: .utf8)
        {
           apiManager.startAPI(endPoint: APIEndpoint.SearchSub, input: nil, isJson: false, retrieved: retrieved)
        }
    }
    
    func testRules()
    {
        let retrieved = RulesRetrieved()
        retrieved.didRetrievedRules =
            { (rules : Rules, endpoint : APIEndpoint) in
                XCTAssert(true)
        }
        retrieved.didRetrievedError = error()
        if let data = responses.subredditrules().data(using: .utf8)
        {
            apiManager.startAPI(endPoint: APIEndpoint.AbtSubRules, input: nil, isJson: false, retrieved: retrieved)
        }
    }
    
    func testSubredditInfo()
    {
        let retrieved = SubredditRetrieved()
        retrieved.didRetrievedSubreddit =
            { (sub : Subreddit, endpoint : APIEndpoint) in
                XCTAssert(true)
        }
        retrieved.didRetrievedError = error()
        if let data = responses.subreddit().data(using: .utf8)
        {
            apiManager.startAPI(endPoint: APIEndpoint.AbtSub, input: nil, isJson: false, retrieved: retrieved)
        }
    }
    
    func testComments()
    {
        let retrieved = CommentsRetrieved()
        retrieved.didRetrievedComments =
            { (listing : [Comments], endpoint : APIEndpoint) in
                XCTAssert(true)
        }
        retrieved.didRetrievedError = error()
        if let data = responses.comments().data(using: .utf8)
        {
            apiManager.startAPI(endPoint: APIEndpoint.ArticleComments, input: nil, isJson: false, retrieved: retrieved)
        }
    }
    
    func testFeed()
    {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing =
            { (listing : FeedListing, endPoint : APIEndpoint) in
                XCTAssert(true)
        }
        retrieved.didRetrievedError = error()
        if let data = responses.news().data(using: .utf8)
        {
            apiManager.startAPI(endPoint: APIEndpoint.News, input: nil, isJson: false, retrieved: retrieved)
            // Popular
            // Trending
            //
        }
    }
    
    func testMe() {
        let meRetrieved = MeRetrieved()
        meRetrieved.didRetrievedMe =
            { (me : Me) in
                
                XCTAssert(true)
        }
        meRetrieved.didRetrievedError = error()
        if let data = responses.me().data(using: .utf8)
        {
            
            apiManager.startAPI(endPoint: APIEndpoint.Me, input: nil, isJson: false, retrieved: meRetrieved)
        }
        //        Me
        //        About
    }
    
    func error() ->  ((Error, Bool) -> Void)?
    {
        return {
            (error : Error, revoked : Bool) in
            print("Listing \(error.localizedDescription)")
            XCTAssert(false)
        }
    }
}
