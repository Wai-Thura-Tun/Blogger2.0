//
//  UIViewControllerExtension.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 19/09/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: - Show loading
    func showLoading() {
        OperationQueue.main.addOperation {
            let loadingIV = UIActivityIndicatorView(style: .large)
            loadingIV.center = self.view.center
            loadingIV.tag = 12345
            loadingIV.startAnimating()
            self.view.addSubview(loadingIV)
        }
    }
    
    //MARK: - Hide loading
    func hideLoading() {
        for view in self.view.subviews {
            if let view = view as? UIActivityIndicatorView, view.tag == 12345 {
                view.stopAnimating()
                view.removeFromSuperview()
                break
            }
        }
    }
    
}
