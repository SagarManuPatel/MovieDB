//
//  SearchController.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

//This Search controller will make api call ton fetch data from Server.

import UIKit

class SearchController : UIViewController {
    
    let viewModel = SearchViewModel()
    
    var searchModel = [ResultModel]()
    var isWaiting : Bool = false
    
    lazy var localSearchView : SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.searchTextField.delegate = self
        view.searchTextField.placeholder = "Enter Moview Name"
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
        return view
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Search"
        self.addCustomViews()
        
        viewModel.delegate = self
    }
    
    private func addCustomViews() {
        view.addSubview(localSearchView)
        view.addSubview(collectionView)
        
        localSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        localSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        localSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        localSearchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        localSearchView.searchTextField.addTarget(self, action: #selector(handelTextDidChanged), for: .editingChanged)
        
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.searchCollectionCell)
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
//        self.estimateWidth = Double((CGFloat(view.frame.size.width) / 2))
        
        collectionView.topAnchor.constraint(equalTo: localSearchView.bottomAnchor , constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

extension SearchController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifiers.searchCollectionCell, for: indexPath) as! SearchCollectionCell
        cell.searchModel = searchModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NavigationHelper.openMoviewDetailVC(moviewId: searchModel[indexPath.item].id ?? 0, controller: self)
    }
}


extension SearchController : UITextFieldDelegate {
    
    @objc func handelTextDidChanged(textField : UITextField) {
        let searchData = textField.text
        
        if searchData?.count ?? 0 >= 3 {
//            hideTrendingCollectionView()
            if !searchData!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: textField)
                self.perform(#selector(self.reload), with: textField, afterDelay: 0.5)
//                self.buttonBarView.isHidden = false
            }
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: textField)
//            setPlaceholderData()
//            self.placeholderView.isHidden = false
//            self.buttonBarView.isHidden = true
        }
    }
    
    @objc func reload(_ textFiled: UITextField) {
        guard let query = textFiled.text, query.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            print("nothing to search")
            return
        }
        let trimmed = query.trimTrailingWhitespaces()
        
        viewModel.fetchSearchResults(query: trimmed, page: 1)
        self.searchModel.removeAll()
        self.collectionView.reloadData()
    }
}

extension SearchController : SearchControllerDelegate {
    
    func handlSearchResultSucessfullyFetched(response: SearchModel) {
        if response.results?.count ?? 0 > 0 {
            self.isWaiting = false
            self.searchModel.append(contentsOf: response.results ?? [])
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func handleFailed() {
        
    }
    
}
