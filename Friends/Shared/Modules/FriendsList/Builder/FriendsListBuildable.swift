//
//  FriendsListBuildable.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// FriendsList builder protocol.
protocol FriendsListBuildable {

    /// Builds the FriendsList view.
    ///
    /// - Returns: FriendsList details view.
    func build() -> UIViewController

}
