//
//  ChatCellTableViewCell.swift
//  MultipeerExample
//
//  Created by Arun J on 10/19/15.
//  Copyright © 2015 Aromal Sasidharan. All rights reserved.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {

    @IBOutlet weak var HeadingTextView: UITextView!
    @IBOutlet weak var contentTextView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
