//
//  FriendsDetailsBuildable.swift
//  Friends
//
//  Created by Md Faizul karim on 29/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// FriendsDetails builder protocol.
protocol FriendsDetailsBuildable {

    /// Builds the FriendsDetails view.
    ///
    /// - Returns: FriendsDetails details view.
    func build() -> UIViewController

}
