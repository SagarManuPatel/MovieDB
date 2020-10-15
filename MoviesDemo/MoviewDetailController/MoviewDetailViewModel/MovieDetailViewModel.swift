//
//  MoviewDetailViewModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

protocol MovieDetailControllerDelegate : class{
    func handleMoviewDetailSuccessResponse(response : MoviewDetailModel)
    func handleMovieDetailFailureResponse()
    func handleVideoResponse(response : MovieDetailVideoModel)
    func handleVideoFailureResponse()
    func handleCastCrewDetailResponse(response : MoviewCastCrewModel)
    func handleCastCrewFailureResponse()
    func handleRecomandationSuccess(response : HomeModel)
}

class MovieDetailViewModel {
    
    weak var delegate : MovieDetailControllerDelegate?
    
    func getMovieDetail(moiveId : Int) {
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchMovieDetail(movieId: moiveId)) { (data, error) in
            if error != nil {
                self.delegate?.handleMovieDetailFailureResponse()
            }else{
                do {
                    let response = try JSONDecoder().decode(MoviewDetailModel.self, from: data!)
                    self.delegate?.handleMoviewDetailSuccessResponse(response: response)
                }catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
    
    func getTrailerVideo(moiveId : Int) {
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchVideo(movieId: moiveId)) { (data, error) in
            if error != nil {
                self.delegate?.handleVideoFailureResponse()
            }else{
                do {
                    let response = try JSONDecoder().decode(MovieDetailVideoModel.self, from: data!)
                    self.delegate?.handleVideoResponse(response: response)
                }catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
    
    func getCastAndCrue(moiveId : Int) {
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchCastCrew(movieId: moiveId)) { (data, error) in
            if error != nil {
                self.delegate?.handleCastCrewFailureResponse()
            }else{
                do {
                    let response = try JSONDecoder().decode(MoviewCastCrewModel.self, from: data!)
                    self.delegate?.handleCastCrewDetailResponse(response: response)
                }catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
    
    func fetchRecommendedMoviews(moiveId : Int) {
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchMoviewRecommendation(movieId: moiveId)) { (data , error) in
            do {
                if let dataReponse = data {
                    let response = try JSONDecoder().decode(HomeModel.self, from: dataReponse)
                    self.delegate?.handleRecomandationSuccess(response: response)
                    print(response)
                }
            }catch let jsonError {
                print(jsonError)
            }
        }
    }
    
}
