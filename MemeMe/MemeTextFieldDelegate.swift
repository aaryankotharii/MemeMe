//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 29/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var defaultText : Bool = true
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if defaultText {
            textField.text = ""
            defaultText = false
        }
    }
}
