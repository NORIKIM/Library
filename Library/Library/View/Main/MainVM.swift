//
//  MainVM.swift
//  Library
//
//  Created by 김지나 on 2023/09/04.
//

import Foundation

protocol MainVMDelegate: AnyObject {
    func finishLoad()
}

class MainVM {
    weak var delegate: MainVMDelegate?
    
    private var bookData: BookWrapper?
    var allBooks = [Book]()
    var books = [Book]()
    
    var isFirstLoad: Bool {
        return books.count == 0
    }
    private var isLoading = false
    private var isLastPage = false
    private var currentKeyword = ""
    private var totalBook = 0
    private var itemPerPage = 19
    
    var numberOfRow: Int {
        return books.count
    }
    
    
    func load(with keyword: String) {
        reset()
        requestSearch(keyword: keyword)
    }
    
    func loadNextPage() {
        updateBookData()
        self.delegate?.finishLoad()
    }
    
    private func reset() {
        isLastPage = false
        totalBook = 0
        currentKeyword = ""
        bookData = nil
        allBooks.removeAll()
        books.removeAll()
    }
    
    private func updateBookData() {
        if !isFirstLoad {
            if books.count == allBooks.count {
                isLastPage = true
            } else {
                let start = books.count
                let end = (books.count + itemPerPage) > allBooks.count ? allBooks.count : books.count + itemPerPage
                let range = start ... end
                let bookList = Array(allBooks[range])
                books.append(contentsOf: bookList)
            }
        } else {
            let allBookList = bookData?.docs ?? []
            if allBookList.count != 0 {
                var bookList = [Book]()
                if allBooks.count < itemPerPage {
                    bookList = allBookList
                } else {
                    bookList = Array(allBookList[0 ... itemPerPage])
                }
                allBooks = allBookList
                books = bookList
            }
            
        }
    }
    
    private func requestSearch(keyword: String) {
        guard !isLastPage else { return }
        isLoading = true
        
        Service.shared.requestSerch(keyword: keyword) { response, error in
            guard error == nil else { return }
            guard let book = response else { return }
            
            self.totalBook = book.numFound
            self.bookData = book
            self.isLoading = false
            self.updateBookData()
            self.delegate?.finishLoad()
        }
    }
    
    func book(at indexPath: IndexPath) -> Book {
        return books[indexPath.item]
    }
}
