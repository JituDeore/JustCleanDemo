//
//  List.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation

struct List {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    var listItems: [ListItem] = []
    
    init?(json: JSONItem) {
        guard let result = json["results"] as? [JSONItem] else{
            return nil
        }
        self.page = json["page"] as? Int ?? 0
        self.total_results = json["total_results"] as? Int ?? 0
        self.total_pages = json["total_pages"] as? Int ?? 0
        self.listItems = result.map({ ListItem(with: $0) }).compactMap({ $0 })
    }
}


