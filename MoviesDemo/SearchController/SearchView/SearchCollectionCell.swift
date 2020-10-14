//
//  SearchCollectionCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class SearchCollectionCell : BaseCollectionCell {
    
    var searchModel : ResultModel? {
        didSet {
            moviewNameLabel.text = searchModel?.title
            if let posterUrl = searchModel?.poster_path {
                let url = "\(Constant.URL.baseImageURL)\(posterUrl)"
                
                imageView.loadImageWithUrl(url)
            }
            releaseDateLabel.text = searchModel?.release_date
        }
    }
    
    let imageView : ImageLoader = {
        let iv = ImageLoader()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let moviewNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "Avengers"
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let releaseDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "24-5-1992"
        return lbl
    }()
    
    override func addCustomViews() {
        addSubview(imageView)
        addSubview(moviewNameLabel)
        addSubview(releaseDateLabel)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        moviewNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        moviewNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor , constant: 8).isActive = true
        moviewNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8).isActive = true
        
        releaseDateLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor , constant: 8).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8).isActive = true
    }
}
