//
//  HomeViewModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import Foundation

protocol HomeControllerDelegate : class {
    func handleDataSucessfullyFetched(response : HomeModel)
    func apiInQueue(isWaiting : Bool)
}


class HomeViewModel {
    
    weak var delegate : HomeControllerDelegate?
    
    func fetchMoviews(page : Int , sort : String) {
        self.delegate?.apiInQueue(isWaiting: true)
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchMoviesList(page: page, sort: sort)) { [weak self] (data , error) in
            do {
                if let dataReponse = data {
                    let response = try JSONDecoder().decode(HomeModel.self, from: dataReponse)
                    self?.delegate?.handleDataSucessfullyFetched(response: response)
                    print(response)
                }
            }catch let jsonError {
                print(jsonError)
            }
        }
    }
}
