//
//  UtilityFactory.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation
protocol UtilityFactory {
    func launchSequencer() -> LaunchSequencer
    func analyticsManager() -> AnalyticsManager
    func apiManager() -> OTAPIManager
    func theme() -> Theme
}
