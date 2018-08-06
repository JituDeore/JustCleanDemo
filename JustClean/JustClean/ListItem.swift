//
//  ListItem.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation

struct ListItem {
    let id: Int
    let title: String
    let vote_count: String?
    let vote_average: String
    let popularity: Double?
    let poster_path: String
    let original_title: String?
    let backdrop_path: String
    let adult: Bool?
    let overview: String?
    let release_date: String?
    
    init?(with jsonResponse: JSONItem) {
        guard let title = jsonResponse["title"] as? String ,
            let id = jsonResponse["id"] as? Int else{
                return nil
        }
        self.id = id
        self.title = title
        self.vote_count = jsonResponse["vote_count"] as? String ?? ""
        self.popularity = jsonResponse["popularity"] as? Double
        self.vote_average = jsonResponse["vote_average"] as? String ?? ""
        self.poster_path = jsonResponse["poster_path"] as? String ?? ""
        self.original_title = jsonResponse["original_title"] as? String ?? ""
        self.backdrop_path = jsonResponse["backdrop_path"] as? String ?? ""
        self.adult = (jsonResponse["adult"] as? Bool) ?? false
        self.overview = jsonResponse["overview"] as? String ?? ""
        self.release_date = jsonResponse["release_date"] as? String ?? ""
    }
}
