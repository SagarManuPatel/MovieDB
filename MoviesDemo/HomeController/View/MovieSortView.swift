//
//  MovieSortView.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class MovieSortView : BaseView {
    
    weak var delegate : HomeViewControllerDelegate?
    
    var selectedIndex = Int() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
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
    
    override func addCustomViews() {
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.register(SortMovieFilterCollectionCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.sortMovieFilterCollectionCell)
        
        self.selectedIndex = 0
    }
}

extension MovieSortView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Helper.getSortModel().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifiers.sortMovieFilterCollectionCell, for: indexPath) as! SortMovieFilterCollectionCell
        cell.sortModel = Helper.getSortModel()[indexPath.item]
        if indexPath.item == selectedIndex {
            cell.titleLabel.backgroundColor = .black
            cell.titleLabel.textColor = .white
        }else{
            cell.titleLabel.backgroundColor = .lightGray
            cell.titleLabel.textColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = estimatedString(Helper.getSortModel()[indexPath.item].name ?? "").width
        
        return CGSize(width: width + 24, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        delegate?.sortMoviewById(id: Helper.getSortModel()[indexPath.item].id ?? "")
    }
    
    private func estimatedString (_ text :String) -> CGRect {
        let size = CGSize(width: self.frame.width, height: 1000)
        
        let nsstring = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: nsstring, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil)
    }
}
