//
//  EndPoints.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
enum APIEndpoint
{
    case Me
    case Friends
    case Karma
    case Prefs
    case Trophies
    case Collection
    case AddPost
    case CreateCollection
    case SubredditCollections
    case Comment
    case FollowPost
    case SendReply
    case SubmitLink
    case TrendingSub
    case Gold
    case ArticleComments
    case Best
    case Hot
    case Popular
    case Home
    case News
    case New
    case Vote
    case Rising
    case Trending
    case Top
    case Controversial
    case Compose
    case DelMsg
    case ReadMsg
    case ReadAllMsg
    case MsgWhere
    case MsgInbox
    case MsgUnread
    case MsgSent
    case Search
    case SrNames
    case SearchSub
    case SearchProf
    case Subscribe
    case AbtSub
    case SubSearch
    case SubWhere
    case SubPopular
    case SubNew
    case SubGold
    case SubDefault
    case UserPopular
    case UserNew
    case Friend
    case FriendInfo
    case UserTrophies
    case About
    case UserOverview
    case UserComments
    case UserSubmitted
    case UserUpvoted
    case MineSubreddit
    case SubByTopic
    case Notifications
    case SubredditPosts
    case Default
    case Input
    case AbtSubRules
    case SubredditInfo
    case SubAll
    
}
class EndPoints: NSObject  {
    
    
    /// method returns the method to be used in httprequest
    ///
    /// - Parameter endpoint: as APIEndpoint the endpoint to be identified what method is needed
    /// - Returns: as String the method to be used in http request
    static func method(endpoint : APIEndpoint) -> String
    {
        switch endpoint {

        case .AddPost:
            return "POST"
        case .CreateCollection:
            return "POST"
        case .Comment:
            return "POST"
        case .FollowPost:
            return "POST"
        case .SendReply:
            return "POST"
        case .SubmitLink:
            return "POST"
        case .Vote:
            return "POST"
        case .Gold:
            return "POST"
    
        case .Compose:
            return "POST"
        case .DelMsg:
            return "POST"
        case .ReadMsg:
            return "POST"
        case .ReadAllMsg:
            return "POST"
      
        case .SearchSub:
            return "POST"
        case .Subscribe:
            return "POST"
            
        default:
            return "GET"
        }
    }
    
    
    /// endpoint returns the endpoint String from the given APIEndpoint Enum
    ///
    /// - Parameters:
    ///   - endpoint: as APIEndpoint the endpoint identifier
    ///   - input: as String the parameter added required for certain endpoints
    /// - Returns: as String the endpoint String from the endpoint
    static func endpoint(endpoint : APIEndpoint, input : String?) -> String
    {
        
        switch endpoint {
        case .Me:
            return "/api/v1/me"
        case .MineSubreddit:
            return "/subreddits/mine/subscriber"
        case .Karma:
            return "/api/v1/me/karma"
        case .Friends:
            return "/api/v1/me/friends"
        case .Prefs:
            return "/api/v1/me/prefs"
        case .Trophies:
            return "/api/v1/me/trophies"
        case .Collection:
            return "/api/v1/collections/collection"
        case .AddPost:
            return "/api/v1/collections/add_post_to_collection"
        case .CreateCollection:
            return "/api/v1/collections/create_collection"
        case .SubredditCollections:
            return "/api/v1/collections/subreddit_collections"
        case .Comment:
            return "/api/comment"
        case .FollowPost:
            return "/api/follow_post"
        case .SendReply:
            return "/api/sendreplies"
        case .SubmitLink:
            return "/api/submit"
        case .Vote:
            return "/api/vote"
        case .Gold:
            return "/api/v1/gold/gild/\(input!)"
        case .TrendingSub:
            return "/api/trending_subreddits"
        case .Best:
            return "/best"
        case .ArticleComments:
            if let input = input?.components(separatedBy: ","), input.count > 0
            {
                return "/\(input[0])/comments/\(input[1])"
            }
            return "/r/hockey/comments/di8bgq"
        case .Hot:
            return "/hot"
        case .New:
            return "/new"
        case .Trending:
            return "/r/trending\(input!)"
        case .Popular:
            return "/r/popular\(input!)"
        case .Home:
            return "/r/home\(input!)"
        case .News:
            return "/r/news\(input!)"
        case .Rising:
            return "/rising"
        case .SubByTopic:
            return "/api/subreddits_by_topic"
        case .Top:
            return "/top"
        case .Controversial:
            return "/controversial"
        case .Compose:
            return "/api/compose"
        case .DelMsg:
            return "/api/del_msg"
        case .ReadMsg:
            return "/api/read_message"
        case .ReadAllMsg:
            return "/api/read_all_messages"
        case .MsgWhere:
            return "/message/where"
        case .MsgInbox:
            return "/message/inbox"
        case .MsgUnread:
            return "/message/unread"
        case .MsgSent:
            return "/message/sent"
        case .Search:
            return "/search"
        case .SrNames:
            return "/api/recommend/sr/srnames"
        case .SearchSub:
            return "/api/search_subreddits?query=\(input!)"
        case .Subscribe:
            return "/api/subscribe"
        case .SearchProf:
            return "/profiles/search"
        case .AbtSub:
            return "/\(input!)/about"
        case .AbtSubRules:
            return "/\(input!)/about/rules"
        case .SubSearch:
            return "/subreddits/search"
        case .SubNew:
            return "/subreddits/new"
        case .SubPopular:
            return "/subreddits/popular"
        case .SubAll:
            return "/subreddits/default?show=all"
        case .SubGold:
            return "/subreddits/gold"
        case .SubDefault:
            return "/subreddits/default"
        case .UserPopular:
            return "/users/popular"
        case .UserNew:
            return "/users/new"
        case .Friend:
            return "/api/friend"
        case .FriendInfo:
            return "/api/v1/me/friends/"
        case .UserTrophies:
            return "/api/v1/me/\(input!)/trophies"
        case .About:
            return "/user/\(input!)/about"
        case .UserOverview:
            return "/user/\(input!)/overview"
        case .UserSubmitted:
            return "/user/\(input!)/submitted"
        case .UserUpvoted:
            return "/user/\(input!)/upvoted"
        case .UserComments:
            return "/user/\(input!)/comments"
        case .Notifications:
            return "/api/v1/me/notifications"
        case .SubredditPosts:
            return "/\(input!)"
        case .SubredditInfo:
            return "/\(input!)/api/info"
        case .Default:
            if let input = input{
                return "https://www.reddit.com/\(input)/.json"
            }
            return "https://www.reddit.com/best/.json"
            
        case .Input:
            return "/\(input!)"
        default:
            return "/api/v1/me"
        }
    }
}
