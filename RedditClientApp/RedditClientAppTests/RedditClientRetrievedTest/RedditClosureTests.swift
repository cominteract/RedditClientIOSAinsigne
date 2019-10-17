//
//  RedditClosureTests.swift
//  RedditClientAppTests
//
//  Created by Andre Insigne on 17/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import XCTest

class RedditClosureTests: XCTestCase {
    let responses = Responses()
    // Closure
    // API
    // Auth
    // Presenter
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.SearchSub, data: data, retrieved: retrieved)
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.AbtSubRules, data: data, retrieved: retrieved)
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.AbtSub, data: data, retrieved: retrieved)
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.ArticleComments, data: data, retrieved: retrieved)
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.News, data: data, retrieved: retrieved)
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
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.Me, data: data, retrieved: meRetrieved)
        }
//        Me
//        About
    }
    
    func testSubmit()
    {
        let post = PostSuccess()
        post.didRetrievedPost =
            { (text : String, endpoint : APIEndpoint) in
                
                XCTAssert(true)
        }
        post.didRetrievedError = error()
        if let data = responses.submitSuccess().data(using: .utf8)
        {
            ClosureResults.apiResults(apiEndpoint: APIEndpoint.SubmitLink, data: data, retrieved: post)
        }
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
