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
    var coverArt: UIImage?
    var url: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]

        url <- map["cover.url"]

    }
    
}

//class CoverArt: Mappable {
//    
//    var url: String?
//    var cloudinary_id: String?
//    var width: Int?
//    var height: Int?
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        url <- map["url"]
//        cloudinary_id <- map["cloudinary_id"]
//        width <- map["width"]
//        height <- map["height"]
//    }
//    
//}
