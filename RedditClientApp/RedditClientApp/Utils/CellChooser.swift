//
//  CellChooser.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class CellChooser: NSObject {

    
    
    // TODO : UNUSED
    func postList(indexPath : IndexPath, categories : [String]?, filteredResults : [FeedChildrenListing]? , tableView : UITableView) -> RedditListTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditListTableViewCell", for: indexPath) as! RedditListTableViewCell
        if let count = categories?.count , (indexPath.row - count) >= 0, let result = filteredResults,  (indexPath.row - count) < result.count{
            let index = indexPath.row - count
            cell.redditListLabel.text = result[index].data?.subreddit_name_prefixed
            if let utc = result[index].data?.created_utc{
                cell.redditLostYearLabel.text = "\(utc.toDate().fromNow())"
                cell.redditListDateLabel.text = utc.toDate().toStringDay()
            }
            if let score = result[index].data?.score, score > 999{
                let scorepoint = (Double(score)/Double(1000)).roundTo(value: 2)
                cell.redditListKarmaLabel.text = "\(scorepoint)k karma"
            }
            else if let score = result[index].data?.score, score < 1000{
                cell.redditListKarmaLabel.text = "\(score) karma"
            }
        }
        return cell
    }
    
    
    /// postList can allocate data from a listing and bind it in RedditListTableViewCell
    ///
    /// - Parameters:
    ///   - indexPath: as IndexPath to identify which cell to populate
    ///   - categories: as Added rows in the search and in browsing subreddits
    ///   - searched: as SearchSubreddit when used in the search
    ///   - tableView: as TableView which contains the cell
    /// - Returns: RedditListTableViewCell
    func postList(indexPath : IndexPath, categories : [String]?, searched : SearchSubreddit? , tableView : UITableView) -> RedditListTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditListTableViewCell", for: indexPath) as! RedditListTableViewCell
        if let count = categories?.count , (indexPath.row - count) >= 0, let result = searched?.subreddits,  (indexPath.row - count) < result.count{
            let index = indexPath.row - count
            cell.redditListLabel.text = result[index].name
            
            if let count = result[index].active_user_count
            {
                cell.redditListKarmaLabel.text = "\(count) online"
            }
            if let count = result[index].subscriber_count
            {
                cell.redditListKarmaLabel.text = "\(count) members"
            }
            if let icon = result[index].icon_img
            {
                cell.redditListImageView.downloadedFrom(link: icon)
            }
        }
        return cell
    }
    
    /// postList can allocate data from a listing and bind it in RedditPostLinkTableViewCell
    ///
    /// - Parameters:
    ///   - indexPath: as IndexPath to identify which cell to populate
    ///   - feedChildrenListing: as FeedChildrenListing to be used to populate
    ///   - tableView: as TableView which contains the cell
    ///   - redditFeed: as the delegate to be used for the posts in opening comments, subreddit details and about
    /// - Returns: as RedditPostLinkTableViewCell
    func postLink(indexPath : IndexPath, feedChildrenListing : [FeedChildrenListing]? , tableView : UITableView, redditFeed :  RedditVertFeedAction?) -> RedditPostLinkTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditPostLinkTableViewCell", for: indexPath) as! RedditPostLinkTableViewCell
    
        
        if let list = feedChildrenListing, list.count > indexPath.row{
            cell.delegate = redditFeed
            cell.index = indexPath.row
            cell.redditBestPostLabel.text = list[indexPath.row].data?.subreddit_name_prefixed
            cell.redditBestPostTitleLabel.text = list[indexPath.row].data?.public_description
            cell.redditBestPostTitleLabel.text = list[indexPath.row].data?.author
            cell.redditBestPostDisplayImageView.image = nil
            if let numcomment = list[indexPath.row].data?.num_comments, let award = list[indexPath.row].data?.total_awards_received ,
                let ups = list[indexPath.row].data?.ups{
                cell.redditBestPostCommentLabel.text = "\(numcomment)"
                
                cell.redditBestPostAwardLabel.text = "\(award)"
                cell.redditBestPostUpvoteLabel.text = "\(ups)"
                if ups > 1000
                {
                    let kups = (Double(ups)/Double(1000)).roundTo(value: 2)
                    cell.redditBestPostUpvoteLabel.text = "\(kups)"
                }
            }
            let image = getLink(list: list, index : indexPath.row)
            cell.redditBestPostImageView.downloadedFrom(link: image)
        }
        return cell
    }
    
    /// postCard can allocate data from a listing and bind it in RedditPostCardTableViewCell
    ///
    /// - Parameters:
    ///   - indexPath: as IndexPath to identify which cell to populate
    ///   - feedChildrenListing: as FeedChildrenListing to be used to populate
    ///   - tableView: as TableView which contains the cell
    ///   - redditFeed: as the delegate to be used for the posts in opening comments, subreddit details and about
    /// - Returns: as RedditPostCardTableViewCell
    func postCard(indexPath : IndexPath, feedChildrenListing : [FeedChildrenListing]? , tableView : UITableView, redditFeed : RedditVertFeedAction?) -> RedditPostCardTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditPostCardTableViewCell", for: indexPath) as! RedditPostCardTableViewCell
        cell.index = indexPath.row
        cell.redditPopularDisplayImageView.image = nil
        if redditFeed == nil
        {
            cell.redditPopularPostHintLabel.isHidden = true
        }
        if let list = feedChildrenListing, list.count > indexPath.row{
            cell.redditPopularLabel.text = list[indexPath.row].data?.subreddit_name_prefixed
            cell.redditPopularTitleLabel.text = list[indexPath.row].data?.title
            cell.redditPopularUserLabel.text = list[indexPath.row].data?.author
            if let hint = list[indexPath.row].data?.post_hint?.uppercased()
            {
                cell.redditPopularPostHintLabel.text = hint.contains("hosted:video") ? "VIDEO" : hint
                cell.redditPopularPostHintLabel.isHidden = true
            }
            cell.delegate = redditFeed
            if let numcomment = list[indexPath.row].data?.num_comments, let award = list[indexPath.row].data?.total_awards_received ,
                let ups = list[indexPath.row].data?.ups{
                
                cell.redditPopularAwardLabel.text = "\(award)"
                cell.redditPopularCommentLabel.text = "\(numcomment)"
                cell.redditPopularUpvoteLabel.text = "\(ups)"
                if numcomment > 1000
                {
                    let kcomment = (Double(numcomment)/Double(1000)).roundTo(value: 2)
                    cell.redditPopularCommentLabel.text = "\(kcomment)k"
                }
                if ups > 1000
                {
                    let kups = (Double(ups)/Double(1000)).roundTo(value: 2)
                    cell.redditPopularUpvoteLabel.text = "\(kups)k"
                }
            }
            
            let image = getLink(list: list, index : indexPath.row)
            cell.redditPopularDisplayImageView.downloadedFrom(link: image)
            
        }
        return cell
    }
    
    
    /// getLink gets the link from a FeedChildrenListing
    ///
    /// - Parameter child: as FeedChildrenListing used in populating the url
    /// - Returns: as String the url to be used in populating
    func getLink(child : FeedChildrenListing) -> String
    {
        if let thumbnail = child.data?.thumbnail{
            if thumbnail != "self" && thumbnail != "default" && thumbnail != "spoiler"{
                return thumbnail
            }
            else if let url = child.data?.url , url.contains("jpg"){
                return url
            }
            else if let count = child.data?.preview?.images?.count, count > 0,
                let image = child.data?.preview?.images?[0], let resolutions = image.resolutions?.count, resolutions > 0,
                let url = child.data?.preview?.images?[0].resolutions?[0].url{
                return url
            }
        }
        return ""
    }
    
    /// getLink gets the link from a [FeedChildrenListing]
    ///
    /// - Parameters:
    ///   - list: [FeedChildrenListing] array form for getting link
    ///   - index: as current index
    /// - Returns: as String the link url used to populate
    func getLink(list : [FeedChildrenListing], index : Int) -> String
    {
        if let thumbnail = list[index].data?.thumbnail{
            if thumbnail != "self" && thumbnail != "default" && thumbnail != "spoiler"{
                return thumbnail
            }
            else if let url = list[index].data?.url , url.contains("jpg"){
                return url
            }
            else if let count = list[index].data?.preview?.images?.count, count > 0,
                let image = list[index].data?.preview?.images?[0], let resolutions = image.resolutions?.count, resolutions > 0,
                let url = list[index].data?.preview?.images?[0].resolutions?[0].url{
                return url
            }
        }
        return ""
    }
}
