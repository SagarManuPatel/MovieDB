//
//  SearchModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import Foundation

struct SearchModel : Codable {
    var total_results : Int?
    var total_pages : Int?
    var results : [ResultModel]?
}
