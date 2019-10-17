//
//  RedditMainViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditMainViewController as RedditMainView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditMainViewController : BaseTabViewController, RedditMainView, UITabBarControllerDelegate{
    
    /// presenter as RedditMainPresenter injected automatically to call implementations
    var presenter: RedditMainPresenter!
    
    /// injector as RedditMainInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditMainInjectorImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if presenter != nil{
            presenter.refreshToken()
        }
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if let index = tabBar.items?.index(of : item), index == 2, isLogged
//        {
//
//        }
//        //isActivity = tabBar.items?.index(of : item) ?? 0 > 0
//    }
    /// opens different vc when logged or not
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[2] && presenter.isLogged()
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditPostFeed) as! RedditPostFeedViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            return false
        }
        if viewController == tabBarController.viewControllers?[3] && !presenter.isLogged()
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditAuthSign) as! RedditAuthSignNavViewController
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}
