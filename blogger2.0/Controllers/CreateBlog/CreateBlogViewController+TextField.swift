//
//  CreateViewController+TableView.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 18/09/2023.
//

import Foundation
import UIKit

extension CreateBlogViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateBtnState()
        return true
    }
    
    func checkValidation() -> Bool {
        guard let title = titleTextField.text, !title.isEmpty else { return false }
        guard let author = authorTextField.text, !author.isEmpty else { return false }
        guard let description = descriptionTextField.text, !description.isEmpty else { return false }
        return true
    }
}
