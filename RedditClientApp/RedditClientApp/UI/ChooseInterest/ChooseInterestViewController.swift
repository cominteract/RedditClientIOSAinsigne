//
//  ChooseInterestViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// ChooseInterestViewController as ChooseInterestView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class ChooseInterestViewController : BaseViewController, ChooseInterestView, UICollectionViewDataSource , InterestAction{

    var currentCategory = ""
    
    var currentCategories = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
  
    @IBOutlet weak var chooseInterestFindCommunityButton: UIButton!
    
    @IBAction func findCommunitiesClicked(_ sender: Any) {
        Config.updateInterest(value: currentCategories)
        Config.appDelegate.openIntro()
    }
    
    func interestClicked(current: String, currentIndex : Int) {
        if !currentCategories.contains(current)
        {
            currentCategories.append(current)
        }
        else
        {
            if let index = currentCategories.index(of: current) {
                currentCategories.remove(at: index)
            }
        }
        if currentCategories.count > 0
        {
            chooseInterestFindCommunityButton.isEnabled = true
        }
    }
    
    func didContain(current: String) -> Bool {
        return currentCategories.contains(current)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedditStoryCollectionViewCell", for: indexPath) as! RedditStoryCollectionViewCell
        cell.delegate = self
        let current = (indexPath.row + 1) * (indexPath.section + 1) - 1
        if current < Constants.categories.count
        {
            cell.currentIndex = current
            cell.redditStoryButton.setTitle(Constants.categories[current], for: UIControl.State.normal)
        }
        return cell
    }
    
    /// presenter as ChooseInterestPresenter injected automatically to call implementations
    var presenter: ChooseInterestPresenter!
    
    /// injector as ChooseInterestInjector injects the presenter with the services and data needed for the implementation
    var injector = ChooseInterestInjectorImplementation()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        if Config.getInterest() != nil
        {
            Config.appDelegate.openIntro()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        injector.inject(viewController: self)
        chooseInterestFindCommunityButton.isEnabled = false
        self.collectionView.register(UINib.init(nibName: "RedditStoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RedditStoryCollectionViewCell")
        
    }
}
