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
    var changesMade = false
    
    struct ItemStruct {
        var name: String
        var desc: String
    }
    var savedItem: ItemStruct?
    
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
        
        if let name = item?.name, let desc = item?.desc {
            savedItem = ItemStruct(name: name, desc: desc)
        }
    }
    
    func setDescTextViewBorder() {
        descTextView.layer.borderWidth = 1.0
        descTextView.layer.borderColor = itemDescriptionBorderColor.cgColor
        descTextView.layer.cornerRadius = 4.0
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print("Save Action")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.saveContext()
        changesMade = false
        if let name = item?.name, let desc = item?.desc {
            savedItem = ItemStruct(name: name, desc: desc)
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {

        if !changesMade {
            // if brand new item hasn't been modified and we're exiting then remove it
            if let item = item {
                if item.name == nil {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    
                    appDelegate.persistentContainer.viewContext.delete(item)
                }
            }
            popBack()
            
        } else {
            self.view.endEditing(true)
            let alert = UIAlertController(title: NSLocalizedString("Really Exit?", comment: "Alert title"), message: NSLocalizedString("You have unsaved changes", comment: "Alert message"), preferredStyle: UIAlertControllerStyle.alert)
            let yesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: "Alert title"), style: UIAlertActionStyle.default, handler: { action in
             
                // restore item to last saved state
                if let savedItem = self.savedItem {
                    self.item?.name = savedItem.name
                    self.item?.desc = savedItem.desc
                }
                self.popBack()
            })
            let noAction = UIAlertAction(title: NSLocalizedString("No", comment: "Alert title"), style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func popBack() {
        guard let nav = navigationController else {
            print("Error no navigation controller, can't pop")
            return
        }
        nav.popViewController(animated: true)
    }
}

// MARK: UITextFieldDelegate
extension ItemDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        changesMade = true
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.item?.desc = updatedText
        }
        
        return true
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        changesMade = true
        if let tvText = textView.text,
            let textRange = Range(range, in: tvText) {
            let updatedText = tvText.replacingCharacters(in: textRange,
                                                       with: text)
            self.item?.desc = updatedText
        }
        return true
    }
}
