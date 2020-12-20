//
//  CastCrewCollectionViewCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class CastCrewCollectionViewCell : BaseCollectionCell {
    
    var isCast : Bool?
    
    var dataResponse : CastCrewModel? {
        didSet {
            if let profileUrl = dataResponse?.profile_path {
                let url = "\(Constant.URL.baseImageURL)\(profileUrl)"
                imageView.loadImageWithUrl(url)
            }else{
                imageView.image = UIImage(named: "default")
            }
            
            nameLabel.text = isCast ?? false ? "\(dataResponse?.name ?? "") as \(dataResponse?.character ?? "")" : dataResponse?.name
        }
    }
    
    let imageHeightWidth : CGFloat = 100.0
    
    let imageView : ImageLoader = {
        let iv = ImageLoader()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 4
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 13)
        return lbl
    }()
    
    override func addCustomViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeightWidth).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeightWidth).isActive = true
        
        imageView.layer.cornerRadius = imageHeightWidth / 2
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor , constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 4).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -4).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -8).isActive = true
        
    }
}
