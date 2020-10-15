//
//  RecommendationCollectionCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 15/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class RecommendationCollectionCell : BaseCollectionCell {
    
    var resultModel : ResultModel? {
        didSet {
            moviewNameLabel.text = resultModel?.title
            if let posterUrl = resultModel?.poster_path {
                let url = "\(Constant.URL.baseImageURL)\(posterUrl)"
                
                imageView.loadImageWithUrl(url)
            }
        }
    }
    
    let imageView : ImageLoader = {
        let iv = ImageLoader()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let moviewNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        return lbl
    }()
    
    override func addCustomViews() {
        addSubview(imageView)
        addSubview(moviewNameLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        moviewNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor , constant: 2).isActive = true
        moviewNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 4).isActive = true
        moviewNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -4).isActive = true
        moviewNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -8).isActive = true
    }
}
