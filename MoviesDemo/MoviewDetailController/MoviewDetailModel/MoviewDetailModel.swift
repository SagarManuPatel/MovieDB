//
//  MoviewDetailModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

struct MoviewDetailModel : Codable{
    var original_title : String?
    var overview: String?
    var release_date: String?
    var vote_average : Double?
    var poster_path : String?
    var runtime : Int?
    var genres : [MoviewDetailGenresModel]?
}

struct MoviewDetailGenresModel : Codable {
    var id : Int?
    var name : String?
}
