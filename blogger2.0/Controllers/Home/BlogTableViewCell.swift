//
//  BlogTableViewCell.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 19/09/2023.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(blog: Blog) {
        titleLabel.text = blog.title
        authorLabel.text = "Author : \(blog.author)"
        descriptionLabel.text = blog.description
    }
}
