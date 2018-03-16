//
//  AricleCellTableViewCell.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit

class AricleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
   
    @IBOutlet weak var articleDescription: UITextView!
    
    
    @IBOutlet weak var urlLink: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        urlLink.isScrollEnabled = false
          urlLink.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
      

        // Configure the view for the selected state
    }
    
    
    func configure(vm:ArticleViewModel){
        title.text = vm.titleText
        articleDescription.text = vm.descriptionText
        urlLink.text = vm.urlText
        articleImage.image = vm.imageData
        
    }

}
