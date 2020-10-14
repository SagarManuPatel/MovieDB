//
//  YoutubePlayer.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import AVKit

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

class YoutubePlayer : NSObject {
    weak var weakSelf : UIViewController?
    var isLoadingActive = false
    
    init(_ weakSelf : UIViewController?) {
        self.weakSelf = weakSelf
    }
    
    func playVideo(urlString: String?) {
        guard let videoIdentifier = urlString else { return }
        guard let weakSelf = weakSelf else { return }
        let playerViewController = AVPlayerViewController()
        NotificationCenter.default.addObserver(weakSelf, selector: #selector(weakSelf.finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        DispatchQueue.main.async {
            weakSelf.present(playerViewController, animated: true, completion: nil)
//            weakSelf.addLoaderWithMessage(message: MGLocalize.loaderMsg)
            DispatchQueue.main.asyncAfter(deadline: .now() + 22, execute: {
                if self.isLoadingActive {
//                    weakSelf.dismissLoader()
                    self.isLoadingActive = false
                }
            })
            self.isLoadingActive = true
            XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
                print("Error = ",error?.localizedDescription ?? "nil")
//                playerViewController?.dismissLoader()
                self.isLoadingActive = false
                if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) ,error == nil {
                    print("Youtube Video Player is Loaded & will start soon..")
                    playerViewController?.player = AVPlayer(url: streamURL)
                    playerViewController?.player?.play()
                } else {
                    print(" Youtube player is Dismissed.")
                    weakSelf.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
