//
//  PopularListing.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


/// FeedListing used in all the posts and variations of posts for displaying content
struct FeedListing : Decodable {
    let kind : String?
    var data : FeedDataListing?
    

}
struct FeedDataListing : Decodable
{
    var children : [FeedChildrenListing]?
}

struct FeedChildrenListing : Decodable
{
    let data : FeedChildDataListing?
}

struct FeedChildDataListing : Decodable
{
    let kind : String?
    let author : String?
    let author_fullname : String?
    let subreddit_name_prefixed : String?
    let display_name : String?
    let title : String?
    let link_flair_text : String?
    let display_name_prefixed : String?
    let public_description : String?
    let subscribers : Int?
    let banner_background_image : String?
    let name : String?
    let preview : FeedChildPreviewListing?
    let subreddit_id : String?
    let id : String?
    let num_comments : Int?
    let created_utc : Double?
    let score : Int?
    let total_awards_received : Int?
    let ups : Int?
    let downs : Int?
    let thumbnail : String?
    let url : String?
    var body : String?
    var was_comment : Bool?
    var post_hint : String?
}

struct FeedChildPreviewListing : Decodable
{
    let images : [FeedChildImagesListing]?
}

struct FeedChildImagesListing : Decodable
{
    let resolutions : [ImageProperty]?
}

struct ImageProperty : Decodable
{
    let url : String?
    let width : Int?
    let height : Int?
}
