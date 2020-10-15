//
//  RecentSerachCollectionCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 15/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class RecentSerachCollectionCell : BaseCollectionCell {
    
    let searchedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .white
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17)
        return lbl
    }()
    
    let sepratorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.9440282534)
        return view
    }()
    
    override func addCustomViews() {
        addSubview(searchedLabel)
        addSubview(sepratorView)
        
        searchedLabel.topAnchor.constraint(equalTo: topAnchor , constant: 4).isActive = true
        searchedLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 4).isActive = true
        searchedLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -4).isActive = true
        searchedLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -4).isActive = true
        
        sepratorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sepratorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sepratorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sepratorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
