//
//  PlayerTableViewCell.swift
//  AddPlayers
//
//  Created by Varun Mathuria on 10/30/15.
//  Copyright © 2015 VarunMathuria. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
