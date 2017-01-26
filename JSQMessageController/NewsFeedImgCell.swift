//
//  NewsFeedImgCell.swift
//  JSQMessageController
//
//  Created by Orange Apps on 25/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class NewsFeedImgCell: UITableViewCell {
    
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTimePosted: UILabel!
    @IBOutlet var lblContent: UILabel!
    @IBOutlet var imgScreenShot: UIImageView!
    @IBOutlet var backGroundView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.backgroundColor = UIColor.white
        backGroundView.layer.masksToBounds = false
        backGroundView.layer.shadowColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1).cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backGroundView.layer.shadowOpacity = 0
        contentView.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
