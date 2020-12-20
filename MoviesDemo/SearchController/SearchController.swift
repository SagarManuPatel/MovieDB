//
//  SearchController.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

//This Search controller will make api call to fetch data from Server.

import UIKit

protocol SearchControllerRecentSearchDelegate : class {
    func doRecentSearch(name : String)
}

class SearchController : UIViewController {
    
    let viewModel = SearchViewModel()
    
    var searchModel = [ResultModel]()
    var isWaiting : Bool = false
    var searchedQuery : String = ""
    var page : Int = 1
    
    lazy var recentSearchView : RecentSearchView = {
        let view = RecentSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    let loader : UIActivityIndicatorView = {
        var l = UIActivityIndicatorView(style: .large)
        l.color = UIColor.white
        l.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1.0)
        l.layer.cornerRadius = 10
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var remoteSearchView : SearchView = {
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
        view.addSubview(remoteSearchView)
        view.addSubview(collectionView)
        view.addSubview(recentSearchView)
        
        view.addSubview(loader)
        
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        remoteSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        remoteSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        remoteSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        remoteSearchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        remoteSearchView.searchTextField.addTarget(self, action: #selector(handelTextDidChanged), for: .editingChanged)
        
        collectionView.register(SearchCollectionCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.searchCollectionCell)
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView.topAnchor.constraint(equalTo: remoteSearchView.bottomAnchor , constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        recentSearchView.topAnchor.constraint(equalTo: remoteSearchView.bottomAnchor , constant: 8).isActive = true
        recentSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        recentSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        recentSearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func hideShowRecentSearchView(isHidden : Bool) {
        recentSearchView.isHidden = isHidden
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
        if let some = LatestSearch.getSearchResults() {
            some.addNewSearchText(text: searchModel[indexPath.item].title ?? "")
        } else {
            let _ = LatestSearch(searchText: searchModel[indexPath.item].title ?? "")
        }
        NavigationHelper.openMoviewDetailVC(moviewId: searchModel[indexPath.item].id ?? 0, controller: self)
    }
    
    //MARK:- Pagination added
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let `self` = self else {return}
            if collectionView.visibleCells.contains(cell) {
                if indexPath.item == self.searchModel.count - 1 && !self.isWaiting{
                    self.page += 1
                    self.fetchData()
                }
            }
        }
    }
}


extension SearchController : UITextFieldDelegate {
    
    @objc func handelTextDidChanged(textField : UITextField) {
        let searchData = textField.text
        
        if searchData?.count ?? 0 >= 2 {
            hideShowRecentSearchView(isHidden: true)
            if !searchData!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: textField)
                self.perform(#selector(self.reload), with: textField, afterDelay: 0.5)
            }
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: textField)
            hideShowRecentSearchView(isHidden: false)
        }
    }
    
    @objc func reload(_ textFiled: UITextField) {
        guard let query = textFiled.text, query.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            print("nothing to search")
            return
        }
        let trimmed = query.trimTrailingWhitespaces().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        self.searchedQuery = trimmed
        self.loader.startAnimating()
        viewModel.fetchSearchResults(query: trimmed, page: 1)
        self.searchModel.removeAll()
        self.collectionView.reloadData()
    }
    
    private func fetchData() {
        viewModel.fetchSearchResults(query: searchedQuery, page: page)
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
            self.loader.stopAnimating()
        }
    }
    
    func handleFailed() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
}

extension SearchController : SearchControllerRecentSearchDelegate {
    func doRecentSearch(name: String) {
        self.loader.startAnimating()
        self.remoteSearchView.searchTextField.text = name
        let trimmed = name.trimTrailingWhitespaces().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        hideShowRecentSearchView(isHidden: true)
        viewModel.fetchSearchResults(query: trimmed, page: 1)
        self.searchModel.removeAll()
        self.collectionView.reloadData()
    }
}
