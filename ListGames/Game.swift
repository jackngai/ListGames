//
//  Game.swift
//  ListGames
//
//  Created by Jack Ngai on 6/21/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Game: Object, Mappable {
    
    dynamic var id:Int = 0
    dynamic var name: String?
    dynamic var coverArt: NSData? = nil
    dynamic var url: String?
    
    override static func primaryKey()-> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["cover.url"]
        if let url = url {
            getData(urlString: "https:" + url)
        } else {
            // set base image
        }
        
    }
    
    private func getData(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }

    }
}

