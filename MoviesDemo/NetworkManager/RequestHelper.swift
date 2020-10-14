//
//  RequestHelper.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class RequestsHelper: NSObject {
    
    class func addRequestProperties(_ request: inout NSMutableURLRequest, ofType type: String){
        // TODO: Remove the apikey header
        request.setValue(Constant.HeaderValues.allowedContentType, forHTTPHeaderField: Constant.HeaderFields.contentType)
        request.httpMethod = type
    }
    
    class func fetchMoviesList(page : Int) -> NSMutableURLRequest {
        let urlCreditPoints = URL(string: "\(Constant.URL.baseURL)movie/now_playing?page=\(page)")
        var movieRequest = NSMutableURLRequest(url: urlCreditPoints! as URL)
        addRequestProperties(&movieRequest, ofType: Constant.RequestMethodTypes.GET)
        return movieRequest
    }
    
    class func fetchMovieDetail(movieId : Int) -> NSMutableURLRequest {
        let urlCreditPoints = URL(string: "\(Constant.URL.baseURL)movie/\(movieId)")
        var movieRequest = NSMutableURLRequest(url: urlCreditPoints! as URL)
        addRequestProperties(&movieRequest, ofType: Constant.RequestMethodTypes.GET)
        return movieRequest
    }
    
    class func fetchCastCrew(movieId : Int) -> NSMutableURLRequest {
        let urlCreditPoints = URL(string: "\(Constant.URL.baseURL)movie/\(movieId)/credits")
        var movieRequest = NSMutableURLRequest(url: urlCreditPoints! as URL)
        addRequestProperties(&movieRequest, ofType: Constant.RequestMethodTypes.GET)
        return movieRequest
    }
    
    class func fetchVideo(movieId : Int) -> NSMutableURLRequest {
        let urlCreditPoints = URL(string: "\(Constant.URL.baseURL)movie/\(movieId)/videos")
        var movieRequest = NSMutableURLRequest(url: urlCreditPoints! as URL)
        addRequestProperties(&movieRequest, ofType: Constant.RequestMethodTypes.GET)
        return movieRequest
    }

}
