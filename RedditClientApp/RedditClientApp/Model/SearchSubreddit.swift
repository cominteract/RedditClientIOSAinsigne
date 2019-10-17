//
//  SearchSubreddit.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// SearchSubreddit used to get the list of searched subreddit through a query
struct SearchSubreddit: Decodable {
    let subreddits : [SubredditList]?
}

struct SubredditList : Decodable {
    
    let icon_img : String?
    let name : String?
    let active_user_count : Int?
    let subscriber_count : Int?
}
