//
//  NavigationHelper.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 19/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

//All Navigation will be Handled in this class

import UIKit

class NavigationHelper : NSObject {
    
    class func openMoviewDetailVC(moviewId : Int , controller : UIViewController) {
        let moviewDetailController = MoviewDetailController()
        moviewDetailController.moviewId = moviewId
        controller.navigationController?.pushViewController(moviewDetailController, animated: true)
    }
    
    class func openSearchController(controller : UIViewController) {
        let searchController = SearchController()
        controller.navigationController?.pushViewController(searchController, animated: true)
    }
}
