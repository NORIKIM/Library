//
//  ImageCacheManager.swift
//  Marvel
//
//  Created by 김지나 on 2023/08/30.
//

import UIKit

class ImageCacheManager: UIImageView {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://covers.openlibrary.org/b/id"
    private let noCoverImgURL = "https://openlibrary.org/images/icons/avatar_book-lg.png"
    
    func loadImage(id: Int?, completion: ((Error?)-> Void)? = nil) {
        var url = URL(string: noCoverImgURL)
        if id != nil {
            url = URL(string: "\(baseURL)/\(id!)-S.jpg")
        }
        
        guard let url = url else { return }
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        var filePath = URL(fileURLWithPath: cachesDirectory.path)
                
        filePath.appendPathComponent(url.lastPathComponent)
        
        // memory cache
        let path = filePath.path
        let cachedKey = NSString(string: path)
        
        if let cachedImage = cache.object(forKey: cachedKey) {
            self.image = cachedImage.resize(newWidth: self.frame.size.width)
            return
        }
        
        // disk cache
        if FileManager.default.fileExists(atPath: path) {
            if let img = UIImage(contentsOfFile: path) {
                cache.setObject(img, forKey: cachedKey)
                self.image = img.resize(newWidth: self.frame.size.width)
                return
            }
        }
        
        // image download
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error != nil, let data = data else {
                completion?(error)
                return
            }
                        
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage.resize(newWidth: self.frame.size.width)
                    self.cache.setObject(downloadedImage, forKey: cachedKey)
                    FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                }
            }
        }.resume()
    }
}
