//
//  FriendsListViewModel.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: FriendsListViewModel
final class FriendsListViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: FriendsListDisplayModel = FriendsListDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [FriendsListDisplayModel] {
        return models.map { FriendsListDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: FriendsListViewModelType

/// Get FriendsListViewModelType protocol methods
extension FriendsListViewModel: FriendsListViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FriendsListViewModelInput) -> FriendsListViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> FriendsListViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        
        let friendsListApiPublisher : PassthroughSubject<FriendsListViewState, Never> = .init()
        input.friendsListApiSubject.flatMap { requestModel -> AnyPublisher<Result<FriendsListResponseModel?, OTError>, Never> in
            friendsListApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.getFriendList(requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                friendsListApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    friendsListApiPublisher.send(.apiSuccess(response: response))
                case .failure(let error):
                    friendsListApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)


        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,friendsListApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()
        return FriendsListViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
