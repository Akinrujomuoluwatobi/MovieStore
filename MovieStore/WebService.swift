//
//  WebService.swift
//  MovieStore
//
//  Created by MAC on 29/05/2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    
}

struct Resource<T: Mappable> {
    let url : URL
    var httpMethod: HttpMethods = .get
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}

//This is more like a generic method to make network calls.
class WebServices {
    //Create a function load of generic type T from the Resource Strucr
    func load<T>(resource: Resource<T>, completion: @escaping (NetworkResponseModel) -> Void) { // The Result<T, NetworkError> is available in Swift 5 the first param is the response when successful and the second param is the response when their is an Error.
        let headers : HTTPHeaders = [
            "x-rapidapi-key" : "ce93f3914cmsha8863aae8ad5f9cp12ffe5jsn8ea012bb450f",
            "useQueryString": "true",
            "x-rapidapi-host": "imdb8.p.rapidapi.com"
        ]
        Alamofire.request(resource.url, method: .get, parameters: nil, headers: headers).responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(NetworkResponseModel(statusCode: response.response?.statusCode ?? 200, errorMessage: nil, errorDesc: nil, data: value, success: true))
            case .failure(let error):
                completion(NetworkResponseModel(statusCode: response.response?.statusCode ?? 400, errorMessage: error.localizedDescription, errorDesc: nil, data: nil, success: false))
                
            }
        }
    }
    
}
