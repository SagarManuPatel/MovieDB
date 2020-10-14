//
//  SearchView.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addCustomViews()
    }
    
    func addCustomViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchView : BaseView {
    
    let searchImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named : "search")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let searchTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Search Locally"
        return tf
    }()
    
    override func addCustomViews() {
        addSubview(searchImageView)
        addSubview(searchTextField)
        
        searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 8).isActive = true
        searchImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        searchImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        searchTextField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor , constant: 8).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
