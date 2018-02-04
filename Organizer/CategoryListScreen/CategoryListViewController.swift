//
//  ViewController.swift
//  Organizer
//
//  Created by Douglas Voss on 2/3/18.
//  Copyright © 2018 VossWareLLC. All rights reserved.
//

import UIKit
import CoreData

class CategoryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let categoryCellId = "CategoryCellId"
    var dataSource = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: categoryCellId)
        
        updateDataSourceFromCoreData()
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        print("Add action")
        
        let alert = UIAlertController(title: NSLocalizedString("Enter Category Name", comment: "Alert title"), message: NSLocalizedString("", comment: "Alert message"), preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: NSLocalizedString("Save", comment: "Alert action"), style: UIAlertActionStyle.default) { action in
            
            guard let textField = alert.textFields?.first,
                let categoryName = textField.text else {
                return
            }
            
            self.addCategoryToCoreData(categoryName: categoryName)
            self.updateDataSourceFromCoreData()
            
            self.tableView.reloadData()
        }
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Alert action"), style: UIAlertActionStyle.cancel)
        alert.addAction(cancelAction)
        
        alert.addTextField()
        
        present(alert, animated: true)
    }
    
    func updateDataSourceFromCoreData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                print("Error, can't access AppDelegate")
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Category")
        
        let sort = NSSortDescriptor(key: #keyPath(Category.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            if let fetchResults = try managedContext.fetch(fetchRequest) as? [Category] {
                dataSource = fetchResults
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addCategoryToCoreData(categoryName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        guard let category = NSEntityDescription.insertNewObject(
            forEntityName: "Category",
            into: appDelegate.persistentContainer.viewContext) as? Category else {
                return
        }
        
        category.name = categoryName
        appDelegate.saveContext()
    }
}

// MARK: UITableViewDataSource
extension CategoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath)
    }
}

// MARK: UITableViewDelegate
extension CategoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let category = dataSource[indexPath.row]
        cell.textLabel?.text = category.name
    }
}
