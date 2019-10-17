//
//  UINavigation.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class UINavigation: NSObject {
    
    static let RedditAbout = "RedditAboutViewController"
    static let RedditDetails = "RedditDetailsViewController"
    static let RedditPostAction = "RedditPostActionViewController"
    static let RedditOAuth = "RedditOAuthViewController"
    static let RedditMain = "RedditMainViewController"
    static let RedditInbox = "RedditInboxViewController"
    static let RedditChat = "RedditChatViewController"
    static let RedditCommunity = "RedditCommunityViewController"
    static let RedditAuthSign = "RedditAuthSignNavViewController"
    static let RedditFilterFeedSearch = "RedditFilterFeedSearchViewController"
    static let RedditFeed = "RedditFeedViewController"
    static let RedditPostFeed = "RedditPostFeedViewController"
    static let ChooseInterest = "ChooseInterestViewController"
    static let RedditPreview = "RedditPreviewViewController"
    static let RedditComment = "RedditDetailCommentsViewController"
    static let RedditBrowse = "RedditBrowseViewController"
    
    
    /// story returns UIStoryboard helper
    ///
    /// - Returns: as UIStoryboard
    static func story() -> UIStoryboard
    {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    
    
    
    /// vc returns UIViewController helper
    ///
    /// - Parameter identifier: as String to identify what vc is going to be returned
     /// - Returns: as UIViewController
    static func vc(identifier : String) -> UIViewController
    {
        return story().instantiateViewController(withIdentifier: identifier)
    }
}
