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
    let itemDescriptionPlaceholderText = "Item Description"
    let itemDescriptionPlaceholderTextColor = UIColor(white: 0.9, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemName = item?.name ?? ""
        print("item name: \(itemName)")
        
        nameTextField.text = item?.name ?? ""
        descTextView.text = item?.desc ?? ""
        
        setDescTextViewBorder()
        
        descTextView.text = itemDescriptionPlaceholderText
        descTextView.textColor = itemDescriptionPlaceholderTextColor
    }
    
    func setDescTextViewBorder() {
        descTextView.layer.borderWidth = 1.0
        descTextView.layer.borderColor = itemDescriptionPlaceholderTextColor.cgColor
        descTextView.layer.cornerRadius = 4.0
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
