//
//  Helper.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class Helper : NSObject {
    
    class func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    class func getSortModel() -> [SortMovieModel]{
        
        var sortModelArray = [SortMovieModel]()
        
        var sortNowPlaying = SortMovieModel()
        sortNowPlaying.id = "now_playing"
        sortNowPlaying.name = "Get Now Playing"
        sortModelArray.append(sortNowPlaying)
        
        var sortLatest = SortMovieModel()
        sortLatest.id = "latest"
        sortLatest.name = "Get Latest"
        sortModelArray.append(sortLatest)
        
        var sortPopuler = SortMovieModel()
        sortPopuler.id = "popular"
        sortPopuler.name = "Get Populer"
        sortModelArray.append(sortPopuler)
        
        var sortTopRated = SortMovieModel()
        sortTopRated.id = "top_rated"
        sortTopRated.name = "Get Top Rated"
        sortModelArray.append(sortTopRated)
        
        var sortUpComing = SortMovieModel()
        sortUpComing.id = "upcoming"
        sortUpComing.name = "Get Upcoming"
        sortModelArray.append(sortUpComing)
        
        return sortModelArray
    }
}
