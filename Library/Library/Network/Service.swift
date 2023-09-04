//
//  Service.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import Foundation
import Moya

enum ServiceError: Error {
    case failDecoding
    case failRequest
}

class Service {
    static let shared = Service()
    private let provider = MoyaProvider<Network>()
    
    func requestSerch(keyword: String, page: Int, completion: @escaping (BookWrapper?, ServiceError?)->()) {
        provider.request(.search(keyword: keyword, page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let book = try response.map(BookWrapper.self)
                    completion(book, nil)
                } catch(let error) {
                    print(error.localizedDescription)
                    completion(nil, .failDecoding)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil, .failRequest)
            }
        }
    }
    
    func requestCover(id: Int) {
        provider.request(.cover(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let img = try response.mapImage()
                    print(img)
                } catch(let error) {
                    print(error.localizedDescription)
                }

            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
}
