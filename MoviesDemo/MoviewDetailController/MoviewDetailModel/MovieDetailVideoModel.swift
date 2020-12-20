//
//  MovieDetailVideoModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

struct MovieDetailVideoModel : Codable {
    var results : [VideoResultModel]?
}


struct VideoResultModel : Codable {
    var key : String?
}
