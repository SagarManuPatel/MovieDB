//
//  SearchViewModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

protocol SearchControllerDelegate : class {
    func handlSearchResultSucessfullyFetched(response : SearchModel)
    func handleFailed()
}

class SearchViewModel {
    
    weak var delegate : SearchControllerDelegate?
    
    func fetchSearchResults(query : String , page : Int) {
        APIManager.sharedInstance.makeApiCallToFetchData(request: RequestsHelper.fetchSearchResults(query: query, page: page)) { (data , error) in
            
            if error != nil {
                self.delegate?.handleFailed()
            }else{
                do {
                    let response = try JSONDecoder().decode(SearchModel.self, from: data!)
                    self.delegate?.handlSearchResultSucessfullyFetched(response: response)
                    print(response)
                }catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
}
