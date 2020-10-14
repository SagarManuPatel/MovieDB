//
//  CastTableViewCell.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class CastCrewTableViewCell : BaseTableViewCell {
    
    var castCrewModel : [CastCrewModel]? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var isCast : Bool? {
        didSet {
            if isCast ?? false{
                titleLabel.text = "Cast"
            }else{
                titleLabel.text = "Crew"
            }
        }
    }
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 4
        lbl.font = .boldSystemFont(ofSize: 13)
        return lbl
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let sepratorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.9440282534)
        return view
    }()
    
    override func addCustomViews() {
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(sepratorView)
        
        collectionView.register(CastCrewCollectionViewCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.castCrewCollectionCell)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor , constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor ,constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -8).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor , constant: -8).isActive = true
        
        sepratorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sepratorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sepratorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sepratorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}


extension CastCrewTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castCrewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifiers.castCrewCollectionCell, for: indexPath) as! CastCrewCollectionViewCell
        cell.isCast = isCast
        cell.dataResponse = castCrewModel?[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
