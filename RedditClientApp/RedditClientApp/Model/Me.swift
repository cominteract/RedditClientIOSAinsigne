//
//  Me.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// Me data used in saving the username to be used in posting text
struct Me : Decodable{
    let has_external_account : Bool?
    let user_is_banned : Bool?
    let user_is_contributor : Bool?
    let banner_img : String?
    let show_media : Bool?
    let community_icon : String?
    let display_name : String?
    let header_img : String?
    let title : String?
    let icon_image : String?
    let coins : Int?
    let over_18 : Bool?
    let icon_size : [Int]?
    let icon_img : String?
    let subscribers : Int?
    let is_default_icon : Bool?
    let name : String?
    let is_default_banner : Bool?
    let url : String?
    let user_is_moderator : Bool?
    let public_description : String?
    let description : String?
    let comment_karma : Int?
    let link_karma : Int?
    let created_utc : Double?
    let display_name_prefixed : String?
    let data : UserData?
    
}
/// UserData for allocating info about the user for the About when clicking the username in a post
struct UserData : Decodable
{
    let has_external_account : Bool?
    let user_is_banned : Bool?
    let user_is_contributor : Bool?
    let banner_img : String?
    let show_media : Bool?
    let community_icon : String?
    let display_name : String?
    let header_img : String?
    let title : String?
    let icon_image : String?
    let coins : Int?
    let over_18 : Bool?
    let icon_size : [Int]?
    let icon_img : String?
    let subscribers : Int?
    let is_default_icon : Bool?
    let name : String?
    let is_default_banner : Bool?
    let url : String?
    let user_is_moderator : Bool?
    let public_description : String?
    let description : String?
    let comment_karma : Int?
    let link_karma : Int?
    let created_utc : Double?
    let subreddit : SubredditData?
    
}

