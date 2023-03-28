//
//  FriendsListRouter.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

/// FriendsListRouter list router. Responsible for navigating from the view.
final class FriendsListRouter {
    /// The navigation controller to use for navigation.
    weak var navigationController: UINavigationController?
    
    /// View controller used to present other views.
    weak var viewController: UIViewController?
    private let dependencyManager: DependencyManager
    
    /// Initializes the view router.
    ///
    /// - Parameter dependencyManager: The app dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /*
    /// Example method to implement for route.
    ///
    func routeToView() {}
    */
    func routeToFriendsDetailsView(data : FriendsListResponseData?){
            if let friendsDetailsVc = dependencyManager.friendDetailsBuilder().build() as? FriendsDetailsViewController {
                friendsDetailsVc.modalPresentationStyle = .overFullScreen
                friendsDetailsVc.displayModel.friendData = data
                self.viewController?.present(friendsDetailsVc, animated: true, completion: nil)
            }
    }
}
