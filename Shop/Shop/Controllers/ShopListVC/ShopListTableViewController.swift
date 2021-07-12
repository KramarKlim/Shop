//
//  ShopListTableViewController.swift
//  Shop
//
//  Created by Клим on 11.07.2021.
//

import UIKit

class ShopListTableViewController: UITableViewController {
    
    var images: [UIImage] = []
    
    let json = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConfigureTableViewCell
        print(images)
        let image = images[indexPath.row]
        let name = json.name[indexPath.row]
        let price = json.price[indexPath.row]
        cell.configure(for: image, name: name, price: price)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let name = json.name[indexPath.row]
        let price = json.price[indexPath.row]
        guard let itemVC = self.storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else { return }
        itemVC.image = image
        itemVC.name = name
        itemVC.price = price
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    private func request() {
        DataManager.shared.configure { image in
            self.images.append(image)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
