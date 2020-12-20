//
//  ImageLoader.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader : UIImageView{
    
    var imageURLString : String?
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    func loadImageWithUrl(_ urlString : String){
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.color = UIColor.init(red: 27/255, green: 108/255, blue: 53/255, alpha: 1.0)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageURLString = urlString
        
        if let newString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) {
            if let url = URL(string: newString) {
                
                image = nil
                activityIndicator.startAnimating()
                
                if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                    
                    self.image = imageFromCache
                    activityIndicator.stopAnimating()
                    return
                }
                
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    
                    if error != nil{
                        print(error as Any)
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.activityIndicator.stopAnimating()
                        })
                        return
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let imgaeToCache = UIImage(data: data!){
                            
                            if self.imageURLString == urlString {
                                self.image = imgaeToCache
                            }
                            
                            self.activityIndicator.stopAnimating()
                            imageCache.setObject(imgaeToCache, forKey: urlString as AnyObject)
                        }
                    })
                }) .resume()
            }
        }
    }
}
