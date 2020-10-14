//
//  MovieCastCrewModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 14/10/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

struct MoviewCastCrewModel : Codable{
    var id : Int?
    var cast : [CastCrewModel]?
    var crew : [CastCrewModel]?
}

struct CastCrewModel : Codable{
    var character : String?
    var name : String?
    var profile_path : String?
    
}
