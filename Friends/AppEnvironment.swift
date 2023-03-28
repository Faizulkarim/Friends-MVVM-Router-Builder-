//
//  AppEnvironment.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import Foundation
import UIKit
/// Bootstrap App Environment
struct AppEnvironment {
    let dependencyManager: DependencyManager
    let rootWindow: UIWindow?
}

extension AppEnvironment {
    
    static func bootstrap(rootWindow: UIWindow?) -> AppEnvironment {
        let dependencyManager = OTDependencyManager.defaultValue
        return AppEnvironment(dependencyManager: dependencyManager,
                              rootWindow: rootWindow)
    }
    
    func startApp() {
        setupDependencyManager()
        dependencyManager.launchSequencer().launch()
    }
    
    private func setupDependencyManager() {
        dependencyManager.configure(rootWindow: rootWindow)
      
    }
}
