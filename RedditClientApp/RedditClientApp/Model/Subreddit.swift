//
//  Subreddit.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// Subreddit used to get info about a certain subreddit
//TODO UNUSED
struct Subreddit: Decodable {
    let data : SubredditData?
}

struct SubredditData : Decodable {
    let title : String?
    let icon_img : String?
    let active_user_count : Int?
    let subscribers : Int?
    let accounts_active : Int?
    let public_description : String?
    let created_utc : Double?
    let banner_img : String?
    let description : String?
    let display_name_prefixed : String?
}
