//
//  ViewController.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var filterResultModel = [ResultModel]()
    private var resultModel = [ResultModel]()
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    var page : Int = 1
    var isWaiting : Bool = false
    var isSearching : Bool = false
    
    //MARK:-  Local Search added
    
    lazy var localSearchView : SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.searchTextField.delegate = self
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
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.addCustomViews()
        viewModel.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(handleSearchTapped))
        
        self.fetchData()
    }
    
    @objc func handleSearchTapped() {
        NavigationHelper.openSearchController(controller: self)
    }
    
    private func fetchData() {
        viewModel.fetchMoviews(page: page)
    }
    
    private func addCustomViews() {
        view.addSubview(localSearchView)
        view.addSubview(collectionView)
        
        localSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        localSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        localSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        localSearchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        localSearchView.searchTextField.addTarget(self, action: #selector(handelTextDidChanged), for: .editingChanged)
        
        collectionView.register(HomeMovieCollectionCell.self, forCellWithReuseIdentifier: Constant.CellIdentifiers.homeMoviewCell)
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        self.estimateWidth = Double((CGFloat(view.frame.size.width) / 2))
        
        collectionView.topAnchor.constraint(equalTo: localSearchView.bottomAnchor , constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK:- CollectionView Extension

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterResultModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifiers.homeMoviewCell, for: indexPath) as! HomeMovieCollectionCell
        cell.backgroundColor = .white
        cell.resultModel = filterResultModel[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: 300)
    }
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
    
    //MARK:- Pagination added , will work whern search text is NIL
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let `self` = self else {return}
            if collectionView.visibleCells.contains(cell) {
                if indexPath.item == self.resultModel.count - 1 && !self.isWaiting && !self.isSearching{
                    self.page += 1
                    self.fetchData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = resultModel[indexPath.item].id {
            NavigationHelper.openMoviewDetailVC(moviewId: id, controller: self)
        }
    }
    
}

//MARK:- API Response Delegate Extension

extension HomeViewController : HomeControllerDelegate {
    
    func handleDataSucessfullyFetched(response: HomeModel) {
        if response.results?.count ?? 0 > 0 {
            self.isWaiting = false
            self.resultModel.append(contentsOf: response.results ?? [])
            self.filterResultModel = self.resultModel
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func apiInQueue(isWaiting: Bool) {
        self.isWaiting = isWaiting
    }

}

extension HomeViewController : UITextFieldDelegate {
    
    @objc func handelTextDidChanged(textField : UITextField) {
        isSearching = textField.text?.isEmpty ?? false ? true : false
        filterResultModel = textField.text?.isEmpty ?? false ?  self.resultModel : resultModel.filter({ (model) -> Bool in
            return model.title?.range(of: textField.text ?? "", options: .caseInsensitive) != nil
        })
        self.collectionView.reloadData()
    }
}
