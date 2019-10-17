//
//  RedditFeedViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

enum FeedType
{
    case SearchTrending
    case Results
    case Recent
    case List
    case Default
    case Trending
}
enum FilterType
{
    case News
    case Popular
    case Home
}

/// RedditFeedViewController as RedditFeedView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)
class RedditFeedViewController : BaseViewController, RedditFeedView, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, RedditVertFeedAction {
    
    /// presenter as RedditFeedPresenter injected automatically to call implementations
    var presenter: RedditFeedPresenter!
    
    /// injector as RedditFeedInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditFeedInjectorImplementation()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptySearchTableView: UITableView!
    
    @IBOutlet weak var editedSearchTableView: UITableView!
    
    var search : UISearchController?
    
    var filterType : FilterType? = FilterType.Home
    
    var newsList : FeedListing?
    
    var popularList : FeedListing?
    
    var homeList : FeedListing?
    
    var subscribedList : FeedListing?
    
    var categories : [String]?
    
    var recentsSearch = [String]()
    
    var trendingList : FeedListing?
    
    var currentIndex = 1
    
    var filteredResults : [FeedChildrenListing]?

    var searchedSubreddit : SearchSubreddit?
    
    var timer: Timer?
    
    var allowed = true
    
    @IBOutlet weak var redditFeedTabBar: UITabBar!
    
    let cellChooser = CellChooser()
    
    /// retrievedSearchedUpdateView after retrieving the listings subreddit searched update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrieveSearchedUpdateView(searched: SearchSubreddit) {
        searchedSubreddit = searched
        DispatchQueue.main.async { [weak self] in
            self?.editedSearchTableView.reloadData()
        }
    }
    
    /// retrievedTrendingUpdateView after retrieving the listings related to trending update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedTrendingUpdateView(listing: FeedListing) {
        trendingList = listing
        DispatchQueue.main.async { [weak self] in
            self?.emptySearchTableView.reloadData()
        }
    }
    
    /// retrievedNewsUpdateView after retrieving the listings related to news uupdate the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedNewsUpdateView(listing: FeedListing) {
        newsList = listing
    }
    
    /// retrievedSubscribedUpdateView after retrieving the listings subreddit subscribed update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedSubscribedUpdateView(listing: FeedListing) {
        subscribedList = listing
    }
    
    /// retrievedHomeUpdateView after retrieving the listings related to user preferences update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedHomeUpdateView(listing: FeedListing) {
        homeList = listing
        DispatchQueue.main.async { [weak self] in
            self?.redditFeedTabBar.selectedItem = self?.redditFeedTabBar.items![1] as! UITabBarItem
            self?.tableView.reloadData()
        }
    }
    
    /// retrievedPopularUpdateView after retrieving the listings related to popular update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedPopularUpdateView(listing: FeedListing) {
        popularList = listing
    }
    
    func reloadFeed(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            if let count = trendingList?.data?.children?.count{
                return recentsSearch.count + count
            }
            return recentsSearch.count
        }
        else if tableView.tag == 2{
            if let count = categories?.count, let resultCount = searchedSubreddit?.subreddits?.count {
                return resultCount + count
            }
            if let count = categories?.count{
                return count
            }
            return 0
        }
        else{
            if filterType == FilterType.Popular,  popularList != nil,let count = popularList?.data?.children?.count{
                return count
            }
            else if filterType == FilterType.News,  newsList != nil,let count = newsList?.data?.children?.count{
                return count
            }
            else if filterType == FilterType.Home,  homeList != nil,let count = homeList?.data?.children?.count{
                return count
            }
        }
        return 0
    }
    
    func getList() -> [FeedChildrenListing]?{
        if let filter = filterType{
            switch filter {
            case .Home:
                return homeList?.data?.children
            case .Popular:
                return popularList?.data?.children
            default:
                return newsList?.data?.children
            }
        }
        return homeList?.data?.children
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch feedType(tableView: tableView, indexPath: indexPath) {
        case .Recent:
           let cell = tableView.dequeueReusableCell(withIdentifier: "RedditRecentSearchedTableViewCell") as! RedditRecentSearchedTableViewCell
           cell.redditRecentSearchedLabel.text = recentsSearch[indexPath.row]
        return cell
        case .SearchTrending:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditSearchTrendingTableViewCell") as! RedditSearchTrendingTableViewCell
            let index = indexPath.row - recentsSearch.count
            if let trending = trendingList?.data?.children, index >= 0, index < trending.count {
                
                if let sub = trending[index].data?.subreddit_name_prefixed
                {
                    cell.redditSearchTrendingLabel.text = sub
                }
                else if let sub = trending[index].data?.subreddit_name_prefixed
                {
                    cell.redditSearchTrendingLabel.text = sub
                }
                
                
                cell.redditSearchTrendingDescLabel.text = trending[index].data?.title
                cell.redditSearchTrendingTitleLabel.text = trending[index].data?.link_flair_text
            }
            return cell
        case .Results:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditSearchResultsTableViewCell") as! RedditSearchResultsTableViewCell
            cell.redditSearchResultsLabel.text = categories?[indexPath.row]
            return cell
        case .List:
            return cellChooser.postList(indexPath: indexPath, categories: categories, searched: searchedSubreddit, tableView: tableView)
        default:
            if let postHint = postHintFor(indexPath: indexPath), (postHint == "link" || postHint == "self"){
                return cellChooser.postLink(indexPath: indexPath, feedChildrenListing: getList(), tableView: tableView, redditFeed: self)
            }
            return cellChooser.postCard(indexPath: indexPath, feedChildrenListing: getList(), tableView: tableView, redditFeed: self)
        }
    }
    
    func feedType(tableView : UITableView, indexPath : IndexPath) -> FeedType{
        if tableView.tag == 1 && indexPath.row < recentsSearch.count{
            return FeedType.Recent
        }
        else if tableView.tag == 1 && indexPath.row >= recentsSearch.count{
            return FeedType.SearchTrending
        }
        else if tableView.tag == 2 , let catecount = categories?.count, indexPath.row < catecount{
            return FeedType.Results
        }
        else if tableView.tag == 2 , let catecount = categories?.count, indexPath.row >= catecount{
            return FeedType.List
        }
        return FeedType.Default
    }
    
    func listDetails(tableView : UITableView, indexPath : IndexPath) -> FeedChildrenListing?{
        return getList()?[indexPath.row]
    }
    
    func postHintFor(indexPath : IndexPath) -> String?{
        return getList()?[indexPath.row].data?.post_hint
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch feedType(tableView: tableView, indexPath: indexPath) {
        case .List,.Recent,.Results:
            return 54
        case .SearchTrending:
            return 120
        default:
            if let postHint = postHintFor(indexPath: indexPath),
                (postHint == "self" || postHint == "link"){
                return 194
            }
            return 380
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch feedType(tableView: tableView, indexPath: indexPath) {
        case .Recent,.Results:
            let vc = UINavigation.vc(identifier: UINavigation.RedditFilterFeedSearch) as! RedditFilterFeedSearchViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case .List:
            if let count = categories?.count, let sr = searchedSubreddit?.subreddits?[indexPath.row - count].name
            {
                let subreddit = "/r/\(sr)"
                moveToDetails(sr: subreddit)
            }
        default:

            print("Good")
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.index(of : item)
        filterType = FilterType.News
        if let index = index, index == 1{
            filterType = FilterType.Home
        }
        else if let index = index, index == 2{
            filterType = FilterType.Popular
        }
        if let index = index, currentIndex != index{
            tableView.animateLtoR(parentView: self.view)
            tableView.reloadData()
            currentIndex = index
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        emptySearchTableView.isHidden = true
        editedSearchTableView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        emptySearchTableView.isHidden = false
        editedSearchTableView.isHidden = true
        tableView.isHidden = true
        tableView.reloadData()
    }
    
    func filteredList(children : FeedChildDataListing?, searchText : String) -> Bool{
        if let children = children{
            var fullnamecontains = false
            var namecontains = false
            if let fullname = children.subreddit_name_prefixed{
                fullnamecontains = fullname.contains(searchText.lowercased())
            }
            if let name = children.name{
                namecontains = name.contains(searchText.lowercased())
            }
            return fullnamecontains || namecontains
        }
        return false
    }
    
    @objc func allowSearch()
    {
        allowed = true
    }
    
    func startSearch()
    {
        allowed = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(RedditFeedViewController.allowSearch), userInfo: nil, repeats: false);
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !recentsSearch.contains(searchText){
            recentsSearch.append(searchText)
        }
        Config.updateRecentSearch(value: recentsSearch)
        emptySearchTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 1{
            emptySearchTableView.isHidden = false
            tableView.isHidden = true
            editedSearchTableView.isHidden = true
            filteredResults = nil
        }
        else{
            if allowed
            {
                presenter.startSearch(input: searchText)
                startSearch()
            }
            categories = Config.getInterest()?.filter({ $0.contains(searchText)})
            filteredResults = popularList?.data?.children
            print(" Filtered Results \(filteredResults?.count)")
            filteredResults = filteredResults?.filter({ filteredList(children: $0.data, searchText: searchText) })
            print(" Filtered Results After \(filteredResults?.count)")
            editedSearchTableView.reloadData()
            emptySearchTableView.isHidden = true
            tableView.isHidden = true
            editedSearchTableView.isHidden = false
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emptySearchTableView.isHidden = true
        tableView.isHidden = false
        editedSearchTableView.isHidden = true
        if Config.getRefreshed() == "Not"
        {
            presenter.refresh()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptySearchTableView.isHidden = true
        tableView.isHidden = false
        editedSearchTableView.isHidden = true
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditPostCardTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostCardTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditPostLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostLinkTableViewCell")
        self.emptySearchTableView.register(UINib.init(nibName: "RedditSearchTrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditSearchTrendingTableViewCell")
        self.emptySearchTableView.register(UINib.init(nibName: "RedditRecentSearchedTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditRecentSearchedTableViewCell")
        self.editedSearchTableView.register(UINib.init(nibName: "RedditSearchResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditSearchResultsTableViewCell")
        self.editedSearchTableView.register(UINib.init(nibName: "RedditListTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditListTableViewCell")
        self.definesPresentationContext = false
        search = UISearchController(searchResultsController: nil)
        search?.searchResultsUpdater = self
        search?.searchBar.delegate = self
        search?.obscuresBackgroundDuringPresentation = false
        search?.searchBar.placeholder = NSLocalizedString("searchPlaceholder", comment: "")
        if let search = search{
            search.hidesNavigationBarDuringPresentation = false
            search.searchBar.searchBarStyle = UISearchBar.Style.minimal
            // Include the search bar within the navigation bar.
            self.navigationItem.titleView = search.searchBar
            self.definesPresentationContext = true
        }
        emptySearchTableView.delegate = self
        emptySearchTableView.dataSource = self
        editedSearchTableView.delegate = self
        editedSearchTableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        redditFeedTabBar.delegate = self
        presenter.startAPI()
        if let recents = Config.getRecentsSearch() {
            recentsSearch = recents
        }
    }
    
    
    /// navigate to RedditDetailsViewController using sr subreddit as parameter
    ///
    /// - Parameter sr: as String the subreddit
    func moveToDetails(sr : String)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditDetails) as! RedditDetailsViewController
        vc.sr = sr
        DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
        }
    }
    
    /// navigate to RedditDetailCommentsViewController using sr subreddit , id and feedChildListing as parameter
    ///
    /// - Parameter sr: as String the subreddit
    func moveToComments(sr : String, feedChildListing : FeedChildrenListing, id : String)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditComment) as! RedditDetailCommentsViewController
        vc.sr = sr
        vc.id = id
        vc.feedChildrenListing = feedChildListing
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    /// openAbout opens the about info (RedditAboutViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openAbout(index: Int, tag: Int) {
        if let author = getList()?[index].data?.author
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditAbout) as! RedditAboutViewController
            vc.author = author
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    /// openPreview opens the preview (RedditPreviewViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openPreview(index: Int, tag: Int) {
        let vc = UINavigation.vc(identifier: UINavigation.RedditPreview) as! RedditPreviewViewController
        if let list = getList(){
            vc.image = cellChooser.getLink(list:  list , index: index)
            vc.previewDate = list[index].data?.created_utc?.toDate().fromNow()
            if let subname = list[index].data?.subreddit_name_prefixed
            {
                vc.previewLabel = subname
            }
            else if let subname = list[index].data?.display_name_prefixed
            {
                vc.previewLabel = subname
            }
            vc.user = list[index].data?.author
            vc.previewTitle = list[index].data?.title
            
            if let comments = list[index].data?.num_comments, let upvotes =  list[index].data?.ups{
                vc.comments = "\(comments)"
                vc.upvote = "\(upvotes)"
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    /// openComments opens the comments (RedditDetailCommentsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openComments(index: Int, tag: Int) {
        if let child = getList()?[index], let subreddit = getList()?[index].data?.subreddit_name_prefixed, let id = getList()?[index].data?.id{
            moveToComments(sr: subreddit, feedChildListing: child , id: id)
        }
        else if let child = getList()?[index], let subreddit = getList()?[index].data?.display_name_prefixed, let id = getList()?[index].data?.id
        {
            moveToComments(sr: subreddit, feedChildListing: child , id: id)
        }
    }
    
    /// openSubreddit opens the subreddit details (RedditDetailsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openSubreddit(index: Int, tag: Int) {
        if let subreddit = getList()?[index].data?.subreddit_name_prefixed{
            moveToDetails(sr: subreddit)
        }
        else if let subreddit = getList()?[index].data?.display_name_prefixed
        {
            moveToDetails(sr: subreddit)
        }
    }
}
