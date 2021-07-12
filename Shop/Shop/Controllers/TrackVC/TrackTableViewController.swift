//
//  TrackTableViewController.swift
//  Shop
//
//  Created by Клим on 12.07.2021.
//

import UIKit

class TrackTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.shared.fetchData()
        print(DataBase.shared.items.count)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.shared.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raw", for: indexPath) as! TrackTableViewCell
        let item = DataBase.shared.items[indexPath.row]
        cell.configure(item: item)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataBase.shared.deleteTask(for: indexPath.row)
            let deleteIndexPath = IndexPath(row: indexPath.row, section: 0)
            tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}
