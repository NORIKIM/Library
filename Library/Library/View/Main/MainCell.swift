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
        guard let book = book else { return }
        let coverID = book.coverID
//        ImageCacheManager.shared.loadImage(id: coverID) { data in
//            let img = UIImage(data: data)
////            DispatchQueue.main.async {
//                self.coverIMG.image = img
////            }
//        }
        loadImage(id: coverID)
    }
    
    func loadImage(id: Int?) {
        coverIMG.loadImage(id: id) { _ in }
    }
    
}
