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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    var item: Item?
    let itemDescriptionBorderColor = UIColor(white: 0.9, alpha: 1.0)
    let itemDescriptionPlaceholderText = "Item Description"
    let itemDescriptionPlaceholderTextColor = UIColor.lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemName = item?.name ?? ""
        print("item name: \(itemName)")
        
        nameTextField.text = item?.name ?? ""
        if let desc = item?.desc {
            descTextView.text = desc
            print("item desc: \(desc)")
        } else {
            descTextView.text = itemDescriptionPlaceholderText
            descTextView.textColor = itemDescriptionPlaceholderTextColor
        }
        
        setDescTextViewBorder()
    }
    
    func setDescTextViewBorder() {
        descTextView.layer.borderWidth = 1.0
        descTextView.layer.borderColor = itemDescriptionBorderColor.cgColor
        descTextView.layer.cornerRadius = 4.0
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print("Save Action")
    }
}

// MARK: UITextFieldDelegate
extension ItemDetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            if let name = textField.text {
                self.item?.name = name
            }
        }
    }
}

// MARK: UITextViewDelegate
extension ItemDetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == descTextView {
            if let desc = textView.text {
                self.item?.desc = desc
            }
        }
        
        if textView.text.isEmpty {
            textView.text = itemDescriptionPlaceholderText
            textView.textColor = itemDescriptionPlaceholderTextColor
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == itemDescriptionPlaceholderTextColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
