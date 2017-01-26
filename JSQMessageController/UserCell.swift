//
//  UserCell.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var stud_id: UILabel!
    @IBOutlet var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = imgUser.frame.width / 2
        imgUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
