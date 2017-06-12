//
//  CustomTableViewCell.swift
//  PullToRefresh
//
//  Created by Jorge Sánchez Vega on 12/6/17.
//  Copyright © 2017 Jorge Sánchez Vega. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var labelCell: UILabel!
    
    //MARK: - Properties
    static let identifier: String = "CustomTableViewCell"

    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
