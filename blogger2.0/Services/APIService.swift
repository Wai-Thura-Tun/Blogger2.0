//
//  APIService.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 18/09/2023.
//

import Foundation

class APIService {
    
    //MARK: - FETCH BLOGS
    func getBlogs(onSuccess:@escaping ([Blog]) -> (), onFailure: @escaping (Error) -> ()) {
        let endPoint = EndPoint.GETBLOG
        let urlString = endPoint.getURL()
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                var blogs: [Blog] = []
                if let blogsDict = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    for blog in blogsDict {
                        let id = blog["id"] as? Int ?? 0
                        let title = blog["title"] as? String ?? ""
                        let author = blog["author"] as? String ?? ""
                        let description = blog["description"] as? String ?? ""
                        let newBlog = Blog(id: id, title: title, description: description, author: author);
                        blogs.append(newBlog)
                    }
                    onSuccess(blogs)
                }
            }
            catch let error {
                onFailure(error)
            }
        }
        task.resume()
    }
    
    //MARK: - CREATE BLOG
    func createBlog(blog: Blog, onSuccess:@escaping (Blog) -> (), onFailure:@escaping (Error) -> ()) {
        let endPoint = EndPoint.ADDBLOG
        let urlString = endPoint.getURL()
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = endPoint.method
        request.allHTTPHeaderFields = endPoint.headers
        let body = [
            "title": blog.title,
            "author": blog.author,
            "description": blog.description
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body,options: .prettyPrinted)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                if let createdData = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    let id = createdData["id"] as? Int ?? 0
                    let title = createdData["title"] as? String ?? ""
                    let author = createdData["author"] as? String ?? ""
                    let description = createdData["description"] as? String ?? ""
                    let createdBlog = Blog(id: id, title: title, description: description, author: author)
                    onSuccess(createdBlog)
                }
            }
            catch let error {
                onFailure(error)
            }
        }
        task.resume()
    }
    
    //MARK: - UPDATE BLOG
    
    func updateBlog(blog: Blog, onSuccess:@escaping (Blog) -> (), onFailure:@escaping (Error) -> ()) {
        let endPoint = EndPoint.UPDATEBLOG
        let urlString = endPoint.getURL(id: blog.id)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = endPoint.method
        request.allHTTPHeaderFields = endPoint.headers
        
        let data = [
            "title": blog.title,
            "author": blog.author,
            "description": blog.description
        ]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: data)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                if let updatedBlog = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                    let id = updatedBlog["id"] as? Int ?? 0
                    let title = updatedBlog["title"] as? String ?? ""
                    let author = updatedBlog["author"] as? String ?? ""
                    let description = updatedBlog["description"] as? String ?? ""
                    let updatedBlog = Blog(id: id, title: title, description: description, author: author)
                    onSuccess(updatedBlog)
                }
            }
            catch let error {
                onFailure(error)
            }
        }
        task.resume()
    }
    
    //MARK: - DELETE BLOG
    
    func deleteBlog(id: Int, onSuccess:@escaping (Bool) -> (), onFailure:@escaping (Error) -> ()) {
        let endPoint = EndPoint.DELETEBLOG
        let urlString = endPoint.getURL(id: id)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = endPoint.method
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                onFailure(error!)
                return
            }
            onSuccess(true)
        }
        task.resume()
    }
}
