//
//  RedditPresenterTests.swift
//  RedditClientAppTests
//
//  Created by Andre Insigne on 17/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import XCTest

class RedditPresenterTests: XCTestCase {
    var redditDetailsView : RedditDetailsViewImplementation!
    var presenter : RedditDetailsPresenterImplementation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        redditDetailsView = RedditDetailsViewImplementation()
        
        let data = APIData()
        let services = ServicesInjector(data : data)
        
        presenter = RedditDetailsPresenterImplementation(view: redditDetailsView, apiManager: services.getAPI(), authManager: services.getAuth())
    }
    
    func testSubRules()
    {
        
        presenter.startAPI(sr: "subreddit")
        XCTAssertTrue(redditDetailsView.rulescalled, " retrieve rules not called")
    }
    func testSubAbout()
    {
        presenter.startAPI(sr: "subabout")
        XCTAssertTrue(redditDetailsView.aboutcalled, " retrieve about not called")
    }
    func testSubPosts()
    {
        
        presenter.startAPI(sr: "subposts")
        XCTAssertTrue(redditDetailsView.postscalled, " retrieve posts not called")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 

}
