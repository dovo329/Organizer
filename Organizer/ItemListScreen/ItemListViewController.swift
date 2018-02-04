//
//  ItemListViewController.swift
//  Organizer
//
//  Created by Douglas Voss on 2/3/18.
//  Copyright © 2018 VossWareLLC. All rights reserved.
//

import Foundation
import UIKit

class ItemListViewController: UIViewController {
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryName = category?.name ?? ""
        print("ItemListViewController category: \(categoryName)")
    }
}
