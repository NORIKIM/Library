//
//  DetailVC.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import UIKit

class DetailVC: UIViewController, Storyboarded {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var coverIMG: ImageCacheManager!
    @IBOutlet weak var authorLB: UILabel!
    @IBOutlet weak var publisherLB: UILabel!
    @IBOutlet weak var isbnLB: UILabel!
    @IBOutlet weak var publishYearLB: UILabel!
    
    weak var coordinator: AppCoordinator?
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLB.text = book.title
        
        let coverID = book.coverID
        coverIMG.loadImage(id: coverID)
        
        if let author = book.authorName {
            authorLB.text! += " \(author[0])"
        }
        
        publisherLB.text! += " \(book.publisher![0])"
        
        if let isbn = book.isbn {
            isbnLB.text! += " \(isbn[0])"
        }
        
        if let year = book.publishYear {
            publishYearLB.text! += String(year)
        }  
    }

}
