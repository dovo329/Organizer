//
//  ItemDetailViewController.swift
//  Organizer
//
//  Created by Douglas Voss on 2/3/18.
//  Copyright © 2018 VossWareLLC. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController {
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemName = item?.name ?? ""
        print("item name: \(itemName)")
    }
}
