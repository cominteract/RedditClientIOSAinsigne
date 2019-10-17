//
//  RedditPostHeaderView.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


/// RedditPostHeaderActions protocol for when actions are made to choose a subreddit or submit the post
protocol RedditPostHeaderActions : class {
    
    /// postClicked submits the POST request to send text and whatever according to PostType
    func postClicked()
    
    /// communityClicked opens RedditCommunityViewController when selecting a particular subreddit followed to in order to submit the request
    func communityClicked()

    /// closeClicked dismisses the current vc
    func closeClicked()
}
class RedditPostHeaderView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    weak var delegate : RedditPostHeaderActions?
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var chooseCommunity: UIButton!
    
    @IBAction func closeClicked(_ sender: Any) {
        delegate?.closeClicked()
    }
    
    
    @IBAction func communityClicked(_ sender: Any) {
        delegate?.communityClicked()
    }
    
    @IBAction func postClicked(_ sender: Any) {
        delegate?.postClicked()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()
    {
        Bundle.main.loadNibNamed("RedditPostHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
