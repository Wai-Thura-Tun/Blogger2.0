//
//  CreateViewController.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 18/09/2023.
//

import UIKit

class CreateBlogViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    private let apiService = APIService()
    var blog: Blog?
    var isBlogEditing: Bool {
        return blog != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        updateBtnState()
    }
    
    func setUp() {
        titleTextField.delegate = self
        authorTextField.delegate = self
        descriptionTextField.delegate = self
        
        if isBlogEditing {
            titleTextField.text = blog!.title
            authorTextField.text = blog!.author
            descriptionTextField.text = blog!.description
        }
    }
    
    func updateBtnState() {
        saveBtn.isEnabled = checkValidation()
        if isBlogEditing {
            saveBtn.setTitle("Update", for: .normal)
        }
        else {
            saveBtn.setTitle("Save", for: .normal)
        }
    }
    
    @IBAction func saveBlog(_ sender: UIButton) {
        let title = titleTextField.text!
        let author = authorTextField.text!
        let description = descriptionTextField.text!
        
        if isBlogEditing {
            let blog = Blog(id: blog!.id, title:title, description: description, author: author)
            apiService.updateBlog(blog: blog) { [weak self] blog in
                OperationQueue.main.addOperation {
                    self?.navigationController?.popViewController(animated: true)
                }
            } onFailure: { error in
                print(error.localizedDescription)
            }

        }
        else {
            let blog = Blog(id: 0, title: title, description: description, author: author)
            apiService.createBlog(blog: blog) { [weak self] blog in
                OperationQueue.main.addOperation {
                    self?.navigationController?.popViewController(animated: true)
                }
            } onFailure: { error in
                print(error.localizedDescription)
            }

        }
        
    }
}
