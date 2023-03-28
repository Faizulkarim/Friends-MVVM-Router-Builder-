//
//  SplashDisplayModelBuilder.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import UIKit
import Foundation
import Combine

// MARK: SplashDisplayModelBuilder
struct SplashDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> SplashDisplayModel {
        return SplashDisplayModel()
    }
}
