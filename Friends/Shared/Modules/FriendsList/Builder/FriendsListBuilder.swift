//
//  FriendsListBuilder.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: Module Builder
/// Builder class to build module
final class FriendsListBuilder: FriendsListBuildable {

    // MARK: Properties
    /// Dependency manager.
    let dependencyManager: DependencyManager

    // MARK: Init/Deinit
    /// Creates new instance with provided dependencies.
    ///
    /// - Parameters:
    ///   - dependencyManager: Dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }

    // MARK: Protocol conformance

    // MARK: FriendsListBuildable
    func build() -> UIViewController {
        let viewModel = FriendsListViewModel(apiManager: dependencyManager.apiManager())
        let view = buildView(viewModel: viewModel, router: buildRouter())
        return view
    }
    
    // MARK: Instance functions

    // MARK: Private Instance Functions
    private func buildView(viewModel: FriendsListViewModel, router: FriendsListRouter) -> FriendsListViewController {
        let theme = dependencyManager.theme()
        let analyticsManager = dependencyManager.analyticsManager()

        let viewController = FriendsListViewController(analyticsManager: analyticsManager,
                                                                     theme: theme,
                                                                     viewModel: viewModel,
                                                                     router: router)

        return viewController
    }

    private func buildRouter() -> FriendsListRouter {
        return FriendsListRouter(dependencyManager: self.dependencyManager)
    }
}
