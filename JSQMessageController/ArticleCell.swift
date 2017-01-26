//
//  ArticleCell.swift
//  feedReader
//
//  Created by Orange Apps on 15/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
