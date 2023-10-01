//
//  EndPointEnum.swift
//  blogger2.0
//
//  Created by Wai Thura Tun on 30/09/2023.
//

import Foundation
import Alamofire

enum EndPoint: String {
    case GETBLOG
    case ADDBLOG
    case UPDATEBLOG
    case DELETEBLOG
    
    var method: String {
        switch self {
        case .GETBLOG:
            return "GET"
        case .ADDBLOG:
            return "POST"
        case .UPDATEBLOG:
            return "PUT"
        case .DELETEBLOG:
            return "DELETE"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .GETBLOG:
            return HTTPMethod(rawValue: "GET")
        case .ADDBLOG:
            return HTTPMethod(rawValue: "POST")
        case .UPDATEBLOG:
            return HTTPMethod(rawValue: "PUT")
        case .DELETEBLOG:
            return HTTPMethod(rawValue: "DELETE")
        }
    }
    
    func getURL(id: Int = 0) -> String {
        let baseURL = "http://localhost:3000"
        switch self {
        case .GETBLOG,.ADDBLOG:
            return "\(baseURL)/blogs"
        case .DELETEBLOG,.UPDATEBLOG:
            return "\(baseURL)/blogs/\(id)"
        }
    }
    
    var headers: [String:String] {
        return ["Content-Type": "application/json"]
    }
}
