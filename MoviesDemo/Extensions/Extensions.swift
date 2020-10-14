//
//  Extensions.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit
import XCDYouTubeKit

extension Dictionary
{
    mutating func addDictionary(subDictionary: Dictionary)
    {
        for (key,value) in subDictionary {
            self.updateValue(value, forKey:key)
        }
    }
   
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self as URL, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        
        // return the url from new url components
        return urlComponents.url
    }
}

extension UIViewController {
    
    func playYoutubeVideo(url : String?) {
        let youtubePlayer = YoutubePlayer(self)
        youtubePlayer.playVideo(urlString: url)
    }
    
    //Notificaiton observer methed of youtube video player it is called When video is finished normally
    @objc func finishVideo() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.removeObserver(self)
        }
    }
}

extension String{
    func trimTrailingWhitespaces() -> String {
        return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
}
