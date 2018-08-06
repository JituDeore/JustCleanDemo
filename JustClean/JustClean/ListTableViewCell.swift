//
//  ListTableViewCell.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Method to display data in the cell
    ///
    /// - Parameter listItem: ListItem object.
    func displayData(with listItem: ListItem) {
        self.titleLabel.text = listItem.title
        self.descriptionLabel.text = listItem.overview
        let imagePath = "http://image.tmdb.org/t/p/w185" + listItem.backdrop_path
        thumbnailImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: nil)
    }
}
