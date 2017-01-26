//
//  MessagesCell.swift
//  JSQMessageController
//
//  Created by Orange Apps on 23/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var message: UILabel!
    @IBOutlet var user_id_message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = imgUser.frame.width / 2
        imgUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
