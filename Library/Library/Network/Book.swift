//
//  Book.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import Foundation

struct BookWrapper: Codable {
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let docs: [Book]?
}

struct Book: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case publishYear = "first_publish_year"
        case isbn
        case coverID = "cover_i"
        case publisher
        case authorName = "author_name"
    }
    
    let title: String?
    let publishYear: Int?
    let isbn: [String]?
    let coverID: Int?
    let publisher: [String]?
    let authorName: [String]?
}
