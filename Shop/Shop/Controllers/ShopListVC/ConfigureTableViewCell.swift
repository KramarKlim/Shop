//
//  ConfigureTableViewCell.swift
//  Shop
//
//  Created by Клим on 11.07.2021.
//

import UIKit

class ConfigureTableViewCell: UITableViewCell {
    
    @IBOutlet var clotherImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    
    func configure(for json: UIImage, name: String, price: Int) {
        self.clotherImage.image = json
        self.nameLabel.text = name
        self.priceLabel.text = String((price)) + " " + "рублей"
    }
}
