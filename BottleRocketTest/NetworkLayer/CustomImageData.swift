//
//  CustomImageData.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import Foundation
import UIKit

class CustomImageData: UIImageView {
    
    //MARK: - Properties
    
    private var task: URLSessionDataTask?
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(from url: URL) {
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
        
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Couldn't load image from url: \(url)")
                return
            }
            self.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
            }
        }
        task.resume()
    }
}
