//
//  HomeMovieCollectionCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit


class BaseCollectionCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomViews()
    }
    
    //MARK:- Override this Method in subclass to add Custom Views
    func addCustomViews(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeMovieCollectionCell : BaseCollectionCell{
    
    var resultModel : ResultModel? {
        didSet {
            moviewNameLabel.text = resultModel?.title
            if let posterUrl = resultModel?.poster_path {
                let url = "\(Constant.URL.baseImageURL)\(posterUrl)"
                
                imageView.loadImageWithUrl(url)
            }
            releaseDateLabel.text = resultModel?.release_date
            ratingLabel.text = "\(resultModel?.vote_average ?? 0.0)"
        }
    }
    
    let imageView : ImageLoader = {
        let iv = ImageLoader()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let releaseDateContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let releaseDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    let moviewNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let ratingLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
    }()
    
    override func addCustomViews() {
        addSubview(imageView)
        addSubview(releaseDateContainerView)
        addSubview(releaseDateLabel)
        addSubview(moviewNameLabel)
        addSubview(ratingLabel)
        
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        
        releaseDateContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        releaseDateContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        releaseDateContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        releaseDateContainerView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        releaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateContainerView.leadingAnchor , constant: 8).isActive = true
        releaseDateLabel.centerYAnchor.constraint(equalTo: releaseDateContainerView.centerYAnchor).isActive = true
        
        moviewNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor , constant: 4).isActive = true
        moviewNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 8).isActive = true
        moviewNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -8).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: moviewNameLabel.bottomAnchor , constant: 4).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 8).isActive = true
    }
    
}
