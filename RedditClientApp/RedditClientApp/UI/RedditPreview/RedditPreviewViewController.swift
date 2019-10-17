//
//  RedditPreviewViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditPreviewViewController: UIViewController {
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var redditPreviewLabel: UILabel!
    
    @IBOutlet weak var redditPreviewUserLabel: UILabel!
    
    @IBOutlet weak var redditPreviewImageView: UIImageView!
    
    @IBOutlet weak var redditPreviewTitleLabel: UILabel!
    
    @IBOutlet weak var redditPreviewDateLabel: UILabel!
    
    @IBOutlet weak var redditPreviewUpvoteClicked: UIImageView!
    
    @IBOutlet weak var redditPreviewUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditPreviewDownvoteLabel: UIImageView!
    

    @IBOutlet weak var redditPreviewReplyImageView: UIImageView!
    
    @IBOutlet weak var redditPreviewShareLabel: UILabel!
    
    
    @IBOutlet weak var redditPreviewCommentLabel: UILabel!
    
    
    var previewLabel : String?
    var user : String?
    var image : String?
    var previewTitle : String?
    var previewDate : String?
    var upvote : String?
    var comments : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redditPreviewUserLabel.text = user
        redditPreviewTitleLabel.text = previewTitle
        redditPreviewDateLabel.text = previewDate
        redditPreviewUpvoteLabel.text = upvote
        redditPreviewCommentLabel.text = comments
        redditPreviewLabel.text = previewLabel
        if let image = image
        {
            redditPreviewImageView.downloadedFrom(link: image)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
