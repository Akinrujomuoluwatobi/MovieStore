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
    
    var i: I?
    var id, l, q: String?
    var rank: Int?
    var s: String?
    var vt: Int?
    var y: Int?
    
    convenience required init(i: I?, id: String?, l: String?, q: String?, rank: Int?, s: String?, vt: Int?, y: Int?) {
        self.init()
        self.i = i
        self.id = id
        self.l = l
        self.q = q
        self.rank = rank
        self.s = s
        self.vt = vt
        self.y = y
    }

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
    
    
    var height: Int?
    var imageURL: String?
    var width: Int?

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
