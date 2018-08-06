//
//  DetailViewController.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var listItem: ListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionLabel.text = listItem.overview
        let imagePath = "http://image.tmdb.org/t/p/w185" + listItem.poster_path
        imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: #imageLiteral(resourceName: "placeHolderImage"))
        self.title = listItem.title
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
