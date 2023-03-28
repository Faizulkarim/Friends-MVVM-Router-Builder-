//
//  EndPointType.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
