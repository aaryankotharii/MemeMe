//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 30/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {

    //MAARK: Outlets
    @IBOutlet var memeImageView: UIImageView!
    @IBOutlet var memeTopLabel: UILabel!
    @IBOutlet var memeBotttomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
