//
//  MoviewDetailController.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

protocol MoviewDetailControllerPlayTrailorDelegate : class{
    func playTrailor(id : String)
}

protocol MovieDetailControllerRecommandationDelegate : class {
    func openMovieDetail(movieId : Int)
}

class MoviewDetailController : UIViewController {
    
    let sections : [DetailSections] = [.video , .detail , .cast , .crew , .recommendations]
    
    var moviewDetailModel : MoviewDetailModel?
    var castCrewModel : MoviewCastCrewModel?
    var movieVideoModel : MovieDetailVideoModel?
    var recommandedResponse : [ResultModel]?
    let viewModel = MovieDetailViewModel()
    
    lazy var tableview : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        return tv
    }()
    
    let loader : UIActivityIndicatorView = {
        var l = UIActivityIndicatorView(style: .large)
        l.color = UIColor.white
        l.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1.0)
        l.layer.cornerRadius = 10
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var moviewId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        viewModel.delegate = self
        makeAPICall()
    }
    
    private func makeAPICall() {
        self.loader.startAnimating()
        viewModel.getMovieDetail(moiveId: moviewId ?? 0)
        viewModel.getCastAndCrue(moiveId: moviewId ?? 0)
        viewModel.getTrailerVideo(moiveId: moviewId ?? 0)
        viewModel.fetchRecommendedMoviews(moiveId: moviewId ?? 0)
    }
    
    private func setupTableView() {
        view.addSubview(tableview)
        view.addSubview(loader)
        
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tableview.register(DetailVideoTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifiers.detailVideoCell)
        tableview.register(DetailTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifiers.detailCell)
        tableview.register(CastCrewTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifiers.castCell)
        tableview.register(DetailRecommendationTableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifiers.recommendationCell)
        
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func reloadSectionInTable(_ section: DetailSections) {
        guard let i = sections.firstIndex(of: section) else {return}
        let indexSet: IndexSet = [i]
        
        DispatchQueue.main.async {
            self.tableview.beginUpdates()
            self.tableview.reloadSections(indexSet, with: .none)
            self.tableview.endUpdates()
            
        }
    }
}

//MARK:- Tableview Delegate Methods

extension MoviewDetailController : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = sections[indexPath.section]
        
        switch currentSection {
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.detailVideoCell, for: indexPath) as! DetailVideoTableViewCell
            cell.imageUrl = moviewDetailModel?.poster_path
            cell.videoId = movieVideoModel?.results?.first?.key
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.detailCell, for: indexPath) as! DetailTableViewCell
            cell.detailModel = moviewDetailModel
            cell.selectionStyle = .none
            return cell
        case.crew:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.castCell, for: indexPath) as! CastCrewTableViewCell
            cell.castCrewModel = castCrewModel?.crew
            cell.isCast = false
            cell.selectionStyle = .none
            return cell
        case .cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.castCell, for: indexPath) as! CastCrewTableViewCell
            cell.castCrewModel = castCrewModel?.cast
            cell.isCast = true
            cell.selectionStyle = .none
            return cell
        case .recommendations:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.recommendationCell, for: indexPath) as! DetailRecommendationTableViewCell
            cell.result = recommandedResponse
            cell.delegate = self
            return cell
        }
    }
}


extension MoviewDetailController : MovieDetailControllerDelegate {
    func handleRecomandationSuccess(response: HomeModel) {
        self.recommandedResponse = response.results
        
        DispatchQueue.main.async {
            self.reloadSectionInTable(.recommendations)
        }
    }
    
    
    func handleMovieDetailFailureResponse() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
    func handleVideoFailureResponse() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
    func handleCastCrewFailureResponse() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
    
    func handleMoviewDetailSuccessResponse(response: MoviewDetailModel) {
        self.moviewDetailModel = response
        
        DispatchQueue.main.async {
            self.navigationItem.title = self.moviewDetailModel?.original_title
            self.loader.stopAnimating()
            self.reloadSectionInTable(.video)
            self.reloadSectionInTable(.detail)
        }
    }
    
    func handleVideoResponse(response : MovieDetailVideoModel) {
        self.movieVideoModel = response
        DispatchQueue.main.async {
            self.reloadSectionInTable(.video)
        }
    }
    
    func handleCastCrewDetailResponse(response : MoviewCastCrewModel) {
        self.castCrewModel = response
        
        DispatchQueue.main.async {
            self.reloadSectionInTable(.cast)
            self.reloadSectionInTable(.crew)
        }
    }
}


extension MoviewDetailController : MoviewDetailControllerPlayTrailorDelegate , MovieDetailControllerRecommandationDelegate{
    func openMovieDetail(movieId: Int) {
        NavigationHelper.openMoviewDetailVC(moviewId: movieId, controller: self)
    }
    
    func playTrailor(id: String) {
        self.playYoutubeVideo(url: id)
    }
}
