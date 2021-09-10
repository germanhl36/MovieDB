//
//  UIImage+Extensions.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
import UIKit
extension UIImageView {
    
    func downloadImage(url urlString:String, placeHolder:UIImage?){
        if let imageOnCache = Constants.IMAGE_CACHE.object(forKey: urlString as NSString) {
            self.image = imageOnCache
        } else {
            if self.image == nil{
                self.image = placeHolder
            }
            guard let url = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error  in
                if error != nil {
                    return
                } else if let data = data,let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                            Constants.IMAGE_CACHE.setObject(image, forKey: urlString as NSString)
                            self.image = image
                    }
                    
                }
            }.resume()
        }
    }
}
