//
//  SplashBuildable.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import Foundation
import UIKit

/// Splash builder protocol.
protocol SplashBuildable {

    /// Builds the Splash view.
    ///
    /// - Returns: Splash details view.
    func build() -> UIViewController

}
