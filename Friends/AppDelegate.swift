//
//  AppDelegate.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties

    /// The app main window.
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    weak var viewController: UIViewController?
    private var activatedFromBackground: Bool = false
    /// The app dependency manager.
    private(set) var dependencyManager: DependencyManager!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        activatedFromBackground = false
        window!.overrideUserInterfaceStyle = .light
        let environment: AppEnvironment = AppEnvironment.bootstrap(rootWindow: window)
        dependencyManager = environment.dependencyManager
        environment.startApp()
        return true
    }



}

