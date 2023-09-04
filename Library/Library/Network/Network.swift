//
//  Network.swift
//  Library
//
//  Created by 김지나 on 2023/09/04.
//

import Foundation
import Moya

enum Network {
    case search(keyword: String, page: Int)
    case cover(id: Int)
}

extension Network: TargetType {
    var baseURL: URL {
        switch self {
        case .search:
            let url = URL(string: "https://openlibrary.org")
            return url!
        case .cover:
            let url = URL(string: "https://covers.openlibrary.org/b/id")
            return url!
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search.json"
        case .cover(let id):
            return "/\(id)-L.jpg"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let keyword, let page):
            let param = ["q": keyword, "page": String(page)]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .cover:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}
