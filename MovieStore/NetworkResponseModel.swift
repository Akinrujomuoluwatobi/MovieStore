//
//  NetworkResponseModel.swift
//  MovieStore
//
//  Created by MAC on 30/05/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

//This struct file is pass newtork response and data to the completion handler
struct NetworkResponseModel {
    var statusCode: Int
    var errorMessage: String?
    var errorDescription: String?
    var data: Any?
    var success = false
    var headers = [String: String]()
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
    
    init(statusCode: Int, errorMessage: String? = nil, errorDesc: String? = nil, data: Any? = nil, success: Bool = false) {
        self.statusCode = statusCode
        self.errorMessage = errorMessage
        self.errorDescription = errorDesc
        self.data = data
        self.success = success
    }
    
    static func initLogoutResponse(errorMessage: String? = nil) -> NetworkResponseModel {
        return NetworkResponseModel(statusCode: 403, errorMessage: errorMessage ?? "Unknown error. Please login again", success: false)
    }
    
    func isSuccess() -> Bool {
        return statusCode == 200 || statusCode == 201
    }
    
    func isFailed() -> Bool {
        return statusCode == 400
    }
    
    func isBadRequest() -> Bool {
        return statusCode == 400
    }
    
    func isAuthorizationError() -> Bool {
        return statusCode == 401 || statusCode == 403
    }
    
    func getErrorMessage(_data : Any) -> String {
        var msg: String = ""
        if let _data = _data as? JSON {
            msg = _data["description"].stringValue
            if msg.isEmpty{
                msg = _data["error"].stringValue
                if msg.isEmpty{
                    msg = _data["errorDescription"].stringValue
                }
            }
        }
        return msg
    }
    
    func getErrorDescription(_data: Any) -> String {
        var desc: String = ""
        if let _data = _data as? JSON {
            desc = _data["errorDescription"].stringValue
            
        }
        return desc
    }
}

struct ArrayResponseModel {
    var page: Int
    var size: Int
    var count: Int
    var data: [Any]
    
    init(page: Int, size: Int, count: Int, data: [Any]) {
        self.page = page
        self.size = size
        self.count = count
        self.data = data
    }
}
