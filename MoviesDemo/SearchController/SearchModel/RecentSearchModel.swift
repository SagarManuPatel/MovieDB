//
//  RecentSearchModel.swift
//  MoviesDemo
//
//  Created by Sagar Patel on 20/12/20.
//  Copyright © 2020 Sagar Patel. All rights reserved.
//

import UIKit

class LatestSearch: Codable {
    private let maxListLength = 5

    class SearchNode: Codable {
        var value: String
        var next: SearchNode?
        
        init(value: String) {
            self.value = value
        }
    }
    
    private var headNode: SearchNode
   
    init(searchText: String) {
        self.headNode = SearchNode(value: searchText)
        saveSearchResults()
    }
    
    private func saveSearchResults(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Constant.UserDefaultKeys.latestSearch)
        }
    }
    
    class func getSearchResults() -> LatestSearch? {
        if let savedPerson = UserDefaults.standard.object(forKey: Constant.UserDefaultKeys.latestSearch) as? Data {
            let decoder = JSONDecoder()
            if let searchResult = try? decoder.decode(self, from: savedPerson) {
                print(searchResult.searchList)
                return searchResult
            }
        }
        return nil
    }
    
     var searchList: [String] {
        get {
            var arr = [String]()
            var temp:SearchNode? = headNode
            while let next = temp {
                arr.append(next.value)
                temp = next.next
            }
            return arr
        }
    }
    
     private func removeLast() {
        var temp: SearchNode? = headNode
        var prev: SearchNode? = headNode
        while temp?.next != nil {
            prev = temp
            temp = temp?.next
        }
        prev?.next = nil
    }
    
    private func isSearchTextAlradyPresent(text: String) -> Bool {
        return searchList.contains(text)
    }
    
    func addNewSearchText(text: String) {
        if isSearchTextAlradyPresent(text: text) {
            return
        }
        let newNode = SearchNode(value: text)
        let tempNode = headNode
        newNode.next = tempNode
        headNode = newNode
        var some: SearchNode? = headNode
        var count = 0
        
        while let someNode = some {
            count += 1
            if count > maxListLength {
                removeLast()
            }
            some = someNode.next
        }
        saveSearchResults()
    }
}
