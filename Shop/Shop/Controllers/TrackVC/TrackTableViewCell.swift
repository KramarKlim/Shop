//
//  TrackTableViewCell.swift
//  Shop
//
//  Created by Клим on 12.07.2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    
    func configure(item: Item) {
        guard let price = item.price, let count = item.count, let size = item.size else { return }
        self.nameLabel.text = item.name
        self.priceLabel.text = "Цена: \(price)"
        self.countLabel.text = "Количество: \(count)"
        self.sizeLabel.text = "Размер: \(size)"
//        guard let image: UIImage = UIImage(data: item.image!) else { return }
//        self.imageView?.image = image
    }
}
