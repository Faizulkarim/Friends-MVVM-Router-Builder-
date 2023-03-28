//
//  FriendsDetailsViewModel.swift
//  Friends
//
//  Created by Md Faizul karim on 29/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: FriendsDetailsViewModel
final class FriendsDetailsViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: FriendsDetailsDisplayModel = FriendsDetailsDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [FriendsDetailsDisplayModel] {
        return models.map { FriendsDetailsDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: FriendsDetailsViewModelType

/// Get FriendsDetailsViewModelType protocol methods
extension FriendsDetailsViewModel: FriendsDetailsViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FriendsDetailsViewModelInput) -> FriendsDetailsViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> FriendsDetailsViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return FriendsDetailsViewModelOutput.init(viewState: viewDidLoadPublisher)
    }

}
