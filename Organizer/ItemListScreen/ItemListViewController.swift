//
//  ItemListViewController.swift
//  Organizer
//
//  Created by Douglas Voss on 2/3/18.
//  Copyright © 2018 VossWareLLC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    let itemCellId = "ItemCellId"
    var dataSource = [Item]()
    var selectedItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryName = category?.name ?? ""
        print("ItemListViewController category: \(categoryName)")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemCellId)
        
        updateDataSourceFromCoreData()
    }
    
    func updateDataSourceFromCoreData() {
        if let items = category?.items {
            dataSource = items.allObjects as? [Item] ?? [Item]()
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: SegueId.ShowItemDetail, sender: self)
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueId.ShowItemDetail {
            if let itemDetailVC = segue.destination as? ItemDetailViewController {
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                
                guard let item = NSEntityDescription.insertNewObject(
                    forEntityName: "Item",
                    into: appDelegate.persistentContainer.viewContext) as? Item else {
                        return
                }
                
                item.photo = nil
                item.name = ""
                item.desc = ""
                
                itemDetailVC.item = item
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: itemCellId, for: indexPath)
    }
}

// MARK: UITableViewDelegate
extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let item = dataSource[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.description
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedItem = dataSource[indexPath.row]
        self.performSegue(withIdentifier: SegueId.ShowItemDetail, sender: self)
    }
}
