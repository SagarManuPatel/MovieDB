//
//  HomeModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 12/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

struct HomeModel : Codable{
    var results : [ResultModel]?
    var page : Int?
}

struct ResultModel : Codable {
    var id : Int?
    var title : String?
    var poster_path : String?
    var release_date : String?
    var vote_average : Double?
}
