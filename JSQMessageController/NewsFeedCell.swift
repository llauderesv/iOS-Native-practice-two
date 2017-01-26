//
//  NewsFeedCell.swift
//  OANewsFeed
//
//  Created by Orange Apps on 23/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lblTimePosted: UILabel!
    @IBOutlet var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
