//
//  BuilderFactory.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation


protocol BuilderFactory {
    
    func splashBuilder() -> SplashBuildable
    func friendlistBuilder() -> FriendsListBuildable
    func friendDetailsBuilder() -> FriendsDetailsBuildable
    
    
}
