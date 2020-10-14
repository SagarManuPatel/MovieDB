//
//  DetailVideoTableViewCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit


class BaseTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCustomViews()
    }
    
    
    func addCustomViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class DetailVideoTableViewCell : BaseTableViewCell{
    
    var imageUrl : String? {
        didSet {
            if let posterUrl = imageUrl {
                let url = "\(Constant.URL.baseImageURL)\(posterUrl)"
                posterImageView.loadImageWithUrl(url)
            }
        }
    }
    
    var videoId : String? {
        didSet {
            if videoId != nil {
                playButton.isHidden = false
            }else{
                playButton.isHidden = true
            }
        }
    }
    
    weak var delegate : MoviewDetailControllerPlayTrailorDelegate?
    
    let posterImageView : ImageLoader = {
        let iv = ImageLoader()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let playButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        btn.setTitle("Trailor", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    override func addCustomViews() {
        addSubview(posterImageView)
        addSubview(playButton)
        
        posterImageView.topAnchor.constraint(equalTo: topAnchor , constant: 16).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor , constant: -8).isActive = true
        
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        playButton.addTarget(self, action: #selector(handlePlayTrailor), for: .touchUpInside)
    }
    
    @objc func handlePlayTrailor() {
        delegate?.playTrailor(id: videoId ?? "")
    }
}
