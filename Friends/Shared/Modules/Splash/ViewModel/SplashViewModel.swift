//
//  SplashViewModel.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation
import UIKit
import Combine

// MARK: SplashViewModel
final class SplashViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: SplashDisplayModel = SplashDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [SplashDisplayModel] {
        return models.map { SplashDisplayModelBuilder.viewModel(from: $0)}
    }
    
}
// MARK: SplashViewModelType

/// Get SplashViewModelType protocol methods
extension SplashViewModel: SplashViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SplashViewModelInput) -> SplashViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> SplashViewState in
                return .noResults
                })
            .eraseToAnyPublisher()

        // Observe loadDataSubject event and perform action
        let loadDataPublisher = input.loadDataSubject
            .map({ input -> SplashViewState in
                return .success(self.displayModel)
                })
            .eraseToAnyPublisher()

        // Merge two publisher
        let viewDidLoadAndLoadDataPublisher = Publishers.Merge(viewDidLoadPublisher,
                                                               loadDataPublisher).eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return SplashViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
