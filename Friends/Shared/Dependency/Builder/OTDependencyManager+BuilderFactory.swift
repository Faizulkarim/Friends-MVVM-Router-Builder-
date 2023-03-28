//
//  OTDependencyManager+BuilderFactory.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation

extension OTDependencyManager {
    func splashBuilder() -> SplashBuildable {
        return SplashBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    func friendlistBuilder() -> FriendsListBuildable {
        return FriendsListBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func friendDetailsBuilder() -> FriendsDetailsBuildable {
        return FriendsDetailsBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    
}
