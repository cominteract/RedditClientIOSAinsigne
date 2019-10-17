//
//  RedditFilterFeedSearchViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

// TODO : Unused
/// RedditFilterFeedSearchViewController as RedditFilterFeedSearchView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)
class RedditFilterFeedSearchViewController : BaseViewController, RedditFilterFeedSearchView {
    
    /// presenter as RedditFilterFeedSearchPresenter injected automatically to call implementations
    var presenter: RedditFilterFeedSearchPresenter!
    
    /// injector as RedditFilterFeedSearchInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditFilterFeedSearchInjectorImplementation()
    
    var search : UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        injector.inject(viewController: self)
        if self.navigationController != nil
        {
            self.definesPresentationContext = false
            search = UISearchController(searchResultsController: nil)
      
            search?.obscuresBackgroundDuringPresentation = false
            search?.searchBar.text = "Whatever passed"
            search?.searchBar.showsCancelButton = false
            if let search = search
            {
                search.hidesNavigationBarDuringPresentation = false
                search.searchBar.searchBarStyle = UISearchBar.Style.minimal
                // Include the search bar within the navigation bar.
                self.navigationItem.titleView = search.searchBar
                self.definesPresentationContext = true
            }
        }
    }

  
}
