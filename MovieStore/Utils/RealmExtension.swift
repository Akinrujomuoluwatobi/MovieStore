//
//  RealmExtension.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import Foundation
import RealmSwift
import ObjectMapper
import Realm
/// Maps object of Realm's List type
func <- <T: Mappable>(left: List<T>, right: Map)
{
    var array: [T]?

    if right.mappingType == .toJSON {
        array = Array(left)
    }

    array <- right

    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}


extension Results {
   func toArray() -> [Element] {
     return compactMap {
       $0
     }
   }
}

@objc(RealmSwiftEmbeddedObject)
open class EmbeddedObject : RLMObjectBase, RealmCollectionValue{
    
}

struct RealmConfig {
    static let configuration = Realm.Configuration(schemaVersion: 1)
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
