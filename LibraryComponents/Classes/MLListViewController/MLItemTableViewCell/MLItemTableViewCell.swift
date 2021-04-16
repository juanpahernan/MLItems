//
//  MLItemTableViewCell.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import UIKit

class MLItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
