//
//  Movies.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import Foundation
import RealmSwift
import ObjectMapper
import SwiftyJSON

// MARK: - Movies
class Movies: Mappable, Codable {
    
    var d: [D]?
    var q: String?
    var v: Int?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        d <- map["d"]
        q <- map["q"]
        v <- map["v"]
    }
}

// MARK: - D
@objcMembers class D: Object, Mappable, Codable {
    convenience required init?(map: Map) {
        self.init()
    }
    
    dynamic var i: I?
    dynamic var id: String = ""
    dynamic var l: String = ""
    dynamic var q: String = ""
    dynamic var rank: Int = 0
    dynamic var s: String = ""
    dynamic var vt: Int = 0
    dynamic var y: Int = 0

    func mapping(map: Map) {
        i <- map["i"]
        id <- map["id"]
        l <- map["l"]
        q <- map["q"]
        rank <- map["rank"]
        s <- map["s"]
        vt <- map["vt"]
        y <- map["y"]
    }
}

// MARK: - I
@objcMembers class I: Object, Mappable, Codable {
    
    
    dynamic var height: Int = 0
    dynamic var imageURL: String = ""
    dynamic var width: Int = 0

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "imageUrl"
        case width
    }

    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        height <- map["height"]
        imageURL <- map["imageUrl"]
        width <- map["width"]
    }
}


extension Movies {
    
    static func all(_ param: String) -> Resource<Movies> {
        guard let url = URL(string: "https://imdb8.p.rapidapi.com/auto-complete") else { fatalError("Url not valid")
            
        }
        let finalURL = url.appending("q", value: param)
        return Resource<Movies>(url: finalURL)
        
    }
    
}
