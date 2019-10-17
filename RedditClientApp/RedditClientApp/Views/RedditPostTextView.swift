//
//  RedditPostTextView.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditPostTextAction for delegating when sending title and text and identifying whether it is a link or a normal text
protocol RedditPostTextAction : class{
   
    ///  sendingTitleAndText delegates sending String parameters identifying whether it is a link or a normal text through PostType
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to send
    ///   - text: as String the text whether normal or link
    ///   - postType: as PostType identifier
    func sendingTitleAndText(title : String, text : String, postType : PostType)
}

class RedditPostTextView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    weak var delegate : RedditPostTextAction?

    
    @IBOutlet weak var redditPostTitleField: UITextField!
    
    
    @IBOutlet weak var redditPostTextField: UITextField!
    
    @IBOutlet var contentView: UIView!
    
  
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
        Bundle.main.loadNibNamed("RedditPostTextView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
