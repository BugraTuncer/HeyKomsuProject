//
//  OwnerTableViewCell.swift
//  GradutionThesis
//
//  Created by Buğra Tunçer on 12.05.2020.
//  Copyright © 2020 Buğra Tunçer. All rights reserved.
//

import UIKit

class OwnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageVieww: UIImageView!
    @IBOutlet weak var customerEmail: UILabel!
    @IBOutlet weak var plateCount: UILabel!
    @IBOutlet weak var nameFood: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
