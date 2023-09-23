//
//  HomeViewController+Router.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 21/09/2023.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func goToCreateBlogVC(blog: Blog?) {
        performSegue(withIdentifier: "createblogsegue", sender: blog)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let createBlogVC = segue.destination as! CreateBlogViewController
        if let blog = sender {
            createBlogVC.blog = blog as? Blog
        }
    }
}
