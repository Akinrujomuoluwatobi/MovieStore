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
