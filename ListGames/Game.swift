//
//  Game.swift
//  ListGames
//
//  Created by Jack Ngai on 6/21/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import Foundation
import ObjectMapper

class Game: Mappable {
    
    var id: Int?
    var name: String?
    var popularity: Float?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        popularity <- map["popularity"]
    }
    
}
