//
//  SplashViewController.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import Foundation
import UIKit
import Combine

// MARK: SplashUpdateUICase

enum SplashUpdateUICase {
    /// update ui with list case based on model
    case renderToOnboard(SplashDisplayModel?)
}

// MARK: SplashViewController

final class SplashViewController: BaseSplashViewController {
    
    // MARK: Private Variables

    private var router: SplashRouter?
    private let viewModel: SplashViewModelType

    // MARK: Interactions
    
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let loadDataSubject = PassthroughSubject<Void, Never>()

    // MARK: Init Functions

    /// Initializes the Splash view.
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: SplashViewModelType,
         router: SplashRouter) {
        self.viewModel = viewModel
        self.router = router
        
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints


    // MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind(to: viewModel)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Setup router
        setupRouter()
        /// Load data signal to observer
        loadDataSubject.send()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}

// MARK: Private Default Methods

private extension SplashViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
     
    }

    /// Bind viewmodel
    private func bind(to viewModel: SplashViewModelType) {
        /// Clear all observer
        disposeBag.cancel()

        let input = SplashViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
                                               loadDataSubject: loadDataSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)

        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: SplashViewState) {
        switch state {
        case .loading:
            /// Show indicator
            break
        case .noResults:
            /// Hide indicator
            break
        case .failure:
            /// Hide indicator
            break
        case .success(let models):
            updateUI(with: .renderToOnboard(models), animate: true)
        }
    }

    /// Update UI
    func updateUI(with updateUICase: SplashUpdateUICase, animate: Bool = true) {
        switch updateUICase {
        case .renderToOnboard:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.router?.routeToFriendsListView()

                
            }
        }
     }
    }
