//
//  RedditDetailsViewImplementation.swift
//  RedditClientAppTests
//
//  Created by Andre Insigne on 17/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditDetailsViewImplementation: RedditDetailsView {
    var rulescalled = false
    var postscalled = false
    var aboutcalled = false
    func retrievedAboutSubRulesUpdateView(rules: Rules) {
        rulescalled = true
    }
    
    func retrievedPostsUpdateView(listing: FeedListing) {
        postscalled = true
    }
    
    func retrievedAboutSubredditUpdateView(subreddit: Subreddit) {
        aboutcalled = true
    }
}
