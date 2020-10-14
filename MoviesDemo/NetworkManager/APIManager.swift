//
//  APIManager.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import Foundation

final class APIManager {
    
    static let sharedInstance = APIManager()
    
    private init(){}
    
    func makeApiCallToFetchData(request : NSMutableURLRequest , complition : @escaping (Data? , Error?) -> ()) {
        
        var urlRequest: URLRequest = request as URLRequest
        urlRequest.timeoutInterval = 10

        var queryParameterURL : URL?
        queryParameterURL = urlRequest.url?.appending([
            URLQueryItem(name: Constant.HeaderFields.apiKey, value: Constant.HeaderValues.apiKey) ,
            URLQueryItem(name: Constant.HeaderFields.language, value: Constant.HeaderValues.language)])

        urlRequest.url = queryParameterURL!
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if error != nil {
                print(error as Any)
                complition(data , error)
                return
            }
            complition(data, error)
        }
        task.resume()
    }
}
