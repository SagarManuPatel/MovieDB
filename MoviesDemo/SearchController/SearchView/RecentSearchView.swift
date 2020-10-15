//
//  RecentSearchView.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 15/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class RecentSearchView : BaseView {
    
    var resentSearchArray : [String]?
    
    weak var delegate : SearchControllerRecentSearchDelegate?
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.text = "Recent Searches"
        return lbl
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func addCustomViews() {
        
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor , constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        
        collectionView.register(RecentSerachCollectionCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.recentSearchCollectionCell)
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor , constant: 16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: 16).isActive = true
        
        getRecentSearchList()
    }
    
    private func getRecentSearchList() {
        if let recents = LatestSearch.getSearchResults() {
            resentSearchArray = recents.searchList
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension RecentSearchView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resentSearchArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifiers.recentSearchCollectionCell, for: indexPath) as! RecentSerachCollectionCell
        cell.searchedLabel.text = resentSearchArray?[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.doRecentSearch(name: resentSearchArray?[indexPath.item] ?? "")
    }
}
