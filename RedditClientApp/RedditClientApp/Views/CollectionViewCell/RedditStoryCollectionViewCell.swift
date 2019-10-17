//
//  RedditStoryCollectionViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// InterestAction protocol used when interst is clicked for toggling the cell
protocol InterestAction : class
{
    
    /// interestClicked delegated when a certain interest is clicked which allows action
    ///
    /// - Parameters:
    ///   - current: as the String selected when clicked
    ///   - currentIndex: as the Int index selected when clicked
    func interestClicked(current : String, currentIndex : Int)
    
    
    
    /// didContain check if it contains the current selected
    ///
    /// - Parameter current: as String the selected to check if the list already contains
    /// - Returns: as Bool whether it contains the selected
    func didContain(current : String) -> Bool
}
class RedditStoryCollectionViewCell: UICollectionViewCell {

    weak var delegate : InterestAction?
    
    @IBOutlet weak var redditStoryButton: UIButton!
    
    var currentIndex : Int = 0
    
    
    @IBAction func storyClicked(_ sender: Any) {
        
        let contains = delegate?.didContain(current: Constants.categories[currentIndex])
        if let contains = contains, contains {
            redditStoryButton.backgroundColor = UIColor.lightGray
            redditStoryButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
        else{
            redditStoryButton.backgroundColor = UIColor.blue
            redditStoryButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        print(currentIndex)
        delegate?.interestClicked(current: Constants.categories[currentIndex], currentIndex: currentIndex)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
