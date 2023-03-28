//
//  SplashRouter.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//
import Foundation
import UIKit

/// SplashRouter list router. Responsible for navigating from the view.
final class SplashRouter {
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
    
    func routeToFriendsListView(){
            if let friendsListVc = dependencyManager.friendlistBuilder().build() as? FriendsListViewController {
                friendsListVc.modalPresentationStyle = .overFullScreen
                self.viewController?.present(friendsListVc, animated: true, completion: nil)
            }
    }
}
