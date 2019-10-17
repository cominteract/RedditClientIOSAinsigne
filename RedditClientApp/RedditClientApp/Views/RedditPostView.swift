//
//  RedditPostView.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit



/// PostAction protocol for delegating actions for when post is going to be submitted through text link etc
protocol PostAction : class {
    
    /// imagePosted when post Image is selected navigate to PostActionViewController ready to submit image
    func imagePosted()
    /// textPosted when post text is selected navigate to PostActionViewController ready to submit text
    func textPosted()
    /// linkPosted when post Link is selected navigate to PostActionViewController ready to submit link
    func linkPosted()
    /// videoPosted when post Link is selected navigate to PostActionViewController ready to submit video
    func videoPosted()
    /// dismissView dismisses the current modally presented vc
    func dismissView()
}
class RedditPostView: UIView {

    
    weak var delegate : PostAction?
    
    
    @IBAction func postTextClicked(_ sender: Any) {
        delegate?.textPosted()
    }
    
    
    @IBAction func postVideoClicked(_ sender: Any) {
        delegate?.videoPosted()
    }
    
    
    @IBAction func postImageClicked(_ sender: Any) {
        delegate?.imagePosted()
    }
    
    
    @IBAction func postLinkClicked(_ sender: Any) {
        delegate?.linkPosted()
    }
    
    
    @IBOutlet weak var redditPostTextImageView: UIImageView!
    
    @IBOutlet weak var redditPostVideoImageView: UIImageView!
   
    
    @IBOutlet weak var redditPostImgImageView: UIImageView!
    
    @IBOutlet weak var redditPostLinkImageView: UIImageView!
    
    
    @IBOutlet var contentView: UIView!
    
    
    @IBAction func closeClicked(_ sender: Any) {
        delegate?.dismissView()
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
        Bundle.main.loadNibNamed("RedditPostView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]


        redditPostTextImageView.addTapGesture(selector: #selector(postTextClicked(_:)), target: self)
        redditPostImgImageView.addTapGesture(selector: #selector(postImageClicked(_:)), target: self)
        redditPostVideoImageView.addTapGesture(selector: #selector(postVideoClicked(_:)), target: self)
        redditPostLinkImageView.addTapGesture(selector: #selector(postLinkClicked(_:)), target: self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
