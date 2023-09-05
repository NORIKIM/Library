//
//  MainCell.swift
//  Library
//
//  Created by 김지나 on 2023/09/04.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var coverIMG: ImageCacheManager!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var authorLB: UILabel!
    
    var book: Book? {
        didSet {
            setCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell() {
        guard let book = self.book else { return }
        
        let coverID = book.coverID
        loadImage(id: coverID)
        
        if book.title == nil {
            titleLB.text = ""
        } else {
            titleLB.text = book.title
        }
        
        if book.authorName == nil {
            authorLB.text = ""
        } else {
            authorLB.text = book.authorName![0]
        }
        
    }
    
    func loadImage(id: Int?) {
//        if let id = id {
            coverIMG.loadImage(id: id, size: "S") { _ in
                
//            }
        }
    }
    
}
