//
//  RedditChatViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditChatViewController as RedditChatView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditChatViewController : BaseViewController, RedditChatView, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    
    /// presenter as RedditChatPresenter injected automatically to call implementations
    var presenter: RedditChatPresenter!
    
    /// injector as RedditChatInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditChatInjectorImplementation()
    
    
    @IBOutlet weak var redditChatTabBar: UITabBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var isDirect = false
    
  
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        isDirect = tabBar.items?.index(of : item) ?? 0 > 0
        self.tableView.reloadData()
    }
    
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "RedditChatRoomTableViewCell") as! RedditChatRoomTableViewCell
        if isDirect
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "RedditDirectChatTableViewCell") as! RedditDirectChatTableViewCell
        }
        
        return cell!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditDirectChatTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditDirectChatTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditChatRoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditChatRoomTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.redditChatTabBar.delegate = self
        
    }
}
