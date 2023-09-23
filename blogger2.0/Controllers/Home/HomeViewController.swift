//
//  HomeViewController.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 18/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var blogTableView: UITableView!
    
    var blogs: [Blog] = []
    private let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blogTableView.dataSource = self
        blogTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getBlogs()
    }
    
    @IBAction func createBlog(_ sender: UIBarButtonItem) {
        goToCreateBlogVC(blog: nil)
    }
    
    func getBlogs() {
        self.showLoading()
        apiService.getBlogs { [weak self] blogs in
            self?.blogs = blogs
            OperationQueue.main.addOperation {
                self?.hideLoading()
                self?.blogTableView.reloadData()
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    func deleteBlog(id: Int) {
        apiService.deleteBlog(id: id) { [weak self] status in
            self?.getBlogs()
        } onFailure: { error in
            print(error.localizedDescription)
        }

    }
    
    deinit {
        print("Home View Controller has been deinitialized")
    }
}
