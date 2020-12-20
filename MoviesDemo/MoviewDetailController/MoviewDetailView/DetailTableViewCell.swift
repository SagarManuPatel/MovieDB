//
//  DetailTableViewCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class DetailTableViewCell : BaseTableViewCell {
    
    var detailModel : MoviewDetailModel? {
        didSet {
            
            if let genres = detailModel?.genres {
                let str = genres.map{$0.name!}
                let genresStr = str.joined(separator: ",")
                let duration = Helper.minutesToHoursMinutes(minutes: detailModel?.runtime ?? 0)
                durationAndgenresLabel.text = "\(duration.0) h \(duration.1) min - \(genresStr)"
            }
            
            descriptionLabel.text = detailModel?.overview
        }
    }
    
    let durationAndgenresLabel :UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = .lightGray
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    let sepratorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.9440282534)
        return view
    }()
    
    override func addCustomViews() {
        addSubview(durationAndgenresLabel)
        addSubview(descriptionLabel)
        addSubview(sepratorView)
        
        durationAndgenresLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        durationAndgenresLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        durationAndgenresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: durationAndgenresLabel.bottomAnchor , constant: 8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -8).isActive = true
        
        sepratorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sepratorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sepratorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sepratorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
