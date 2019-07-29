//
//  SearchTableViewCell.swift
//  MoviesApp
//
//  Created by Guillermo Gutierrez on 7/29/19.
//  Copyright © 2019 ggutierrez. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchCellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
