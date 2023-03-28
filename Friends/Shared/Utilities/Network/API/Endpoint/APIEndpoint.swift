//
//  APIEndpoint.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation


public enum APIEndpoint {
    
    case FriendList(params: Parameters)
    
    
}
extension APIEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return Constants.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .FriendList:
            return "api"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .FriendList:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .FriendList(let params):
            print(params)
          return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self  {
        case .FriendList:
            return nil
        }
    }
    
}
