//
//  TableViewCell.swift
//  JSQMessageController
//
//  Created by Orange Apps on 22/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var id: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
