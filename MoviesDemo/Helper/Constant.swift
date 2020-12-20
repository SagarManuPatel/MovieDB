//
//  Constant.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import Foundation

enum DetailSections : Int{
    case video , detail , cast , crew , recommendations
}

class Constant: NSObject {
    
    struct HeaderFields {
        static let contentType = "Content-Type"
        static let apiKey = "api_key"
        static let language = "language"
    }

    struct HeaderValues {
        static let allowedContentType = "application/json"
        static let apiKey = "5675e2bacaa760affd2f81f2c0a27f18"
        static let language = "en-US"
    }
    
    struct RequestMethodTypes {
        static let POST = "POST"
        static let PUT = "PUT"
        static let GET = "GET"
        static let DELETE = "DELETE"
        static let PATCH = "PATCH"
    }
    
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let baseImageURL = "https://image.tmdb.org/t/p/w500"
        static let baseYoutubeURL = "https://www.youtube.com/watch?v="
    }
    
    
    struct CellIdentifiers {
        static let homeMoviewCell = "HomeMovieCollectionCell"
        static let detailVideoCell = "DetailVideoTableViewCell"
        static let detailCell = "DetailTableViewCell"
        static let castCell = "CastTableViewCell"
        static let castCrewCollectionCell = "CastCrewCollectionViewCell"
        static let searchCollectionCell = "SearchCollectionCell"
        static let recentSearchCollectionCell = "RecentSerachCollectionCell"
        static let recommendationCell = "DetailRecommendationTableViewCell"
        static let recommendationCollectionCell = "RecommendationCollectionCell"
        static let sortMovieFilterCollectionCell = "SortMovieFilterCollectionCell"
    }
    
    struct UserDefaultKeys {
        static let latestSearch = "latestSearch"
    }
}
