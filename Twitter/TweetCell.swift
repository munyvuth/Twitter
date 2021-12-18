//
//  TweetCell.swift
//  Twitter
//
//  Created by Muny Vuth on 12/10/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var favorited : Bool = false
    var tweetId : Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //function will set the image of the button based on state
    func setFavorite(_ isFavorited : Bool) {
        favorited = isFavorited
        if favorited == true {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        //updating twitter API based on to be state of favorite button
        let toBeFavorited = !favorited
        
        if toBeFavorited == true {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                //call for function to change image based on state
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Error setting favorite \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Error unfavoriting \(Error)")
            })
        }
        
    }
    
    func setRetweet(_ isRetweeted : Bool) {
        if isRetweeted == true {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.postRetweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: { (Error) in
            print("Error posting retweet \(Error)")
        })
    }
    
}
