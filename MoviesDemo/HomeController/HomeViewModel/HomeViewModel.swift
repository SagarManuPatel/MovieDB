//
//  HomeViewModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import Foundation

protocol HomeControllerDelegate : class {
    func handleDataSucessfullyFetched(response : HomeModel)
    func apiInQueue(isWaiting : Bool)
}


class HomeViewModel {
    
    weak var delegate : HomeControllerDelegate?
    
    func fetchMoviews(page : Int) {
        self.delegate?.apiInQueue(isWaiting: true)
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchMoviesList(page: page)) { (data , error) in
            do {
                let response = try JSONDecoder().decode(HomeModel.self, from: data!)
                self.delegate?.handleDataSucessfullyFetched(response: response)
                print(response)
            }catch let jsonError {
                print(jsonError)
            }
        }
    }
}
