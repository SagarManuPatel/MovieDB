//
//  SortMovieFilterCollectionCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class SortMovieFilterCollectionCell : BaseCollectionCell {
    
    var sortModel : SortMovieModel? {
        didSet {
            titleLabel.text = sortModel?.name
        }
    }
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .yellow
        lbl.font = .systemFont(ofSize: 15)
        lbl.textAlignment = .center
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 6
        return lbl
    }()
    
    override func addCustomViews() {
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor , constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -4).isActive = true
    }
}
