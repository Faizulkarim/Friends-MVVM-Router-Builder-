//
//  FriendsDetailsDisplayModelBuilder.swift
//  Friends
//
//  Created by Md Faizul karim on 29/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import Combine

// MARK: FriendsDetailsDisplayModelBuilder
struct FriendsDetailsDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> FriendsDetailsDisplayModel {
        return FriendsDetailsDisplayModel()
    }
}
