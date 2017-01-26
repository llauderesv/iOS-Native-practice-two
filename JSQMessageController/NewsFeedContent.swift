//
//  NewsFeedContent.swift
//  JSQMessageController
//
//  Created by Orange Apps on 28/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class NewsFeedContent: UITableViewCell {

    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lblTimePosted: UILabel!
    @IBOutlet var lblContent: UILabel!
    @IBOutlet var btnLikeContent: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
