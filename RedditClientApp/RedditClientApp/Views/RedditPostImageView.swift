//
//  RedditPostImageView.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// RedditPostTextAction for delegating when sending title and media and identifying whether it is a video or an image
protocol RedditPostMediaAction : class{
    ///  sendingTitleAndMedia delegates sending String and Data parameters identifying whether it is a image or a video through PostType
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to send
    ///   - media: as Data the data whether video or image
    ///   - postType: as PostType identifier
    func sendingTitleAndMedia(title : String, media : Data, postType : PostType)
}

class RedditPostImageView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBOutlet weak var redditPostTitleField: UITextField!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var redditPostCameraImageView: UIImageView!
    
    @IBOutlet weak var redditPostLibraryImageView: UIImageView!
    
    weak var delegate : RedditPostMediaAction?

    @IBAction func libraryClicked(_ sender: Any) {
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
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
        Bundle.main.loadNibNamed("RedditPostImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
