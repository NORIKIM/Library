//
//  Network.swift
//  Library
//
//  Created by 김지나 on 2023/09/04.
//

import Foundation
import Moya

enum Network {
    case search(keyword: String)
}

extension Network: TargetType {
    var baseURL: URL {
        let url = URL(string: "https://openlibrary.org")
        return url!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let keyword):
            let param = ["q": keyword]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}
