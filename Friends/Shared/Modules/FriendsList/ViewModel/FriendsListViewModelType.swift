//
//  FriendsListViewModelType.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: FriendsListViewModelInput
struct FriendsListViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let friendsListApiSubject : AnyPublisher<Parameters, Never>
}

// MARK: ViewModelOutput
struct FriendsListViewModelOutput {
    let viewState: AnyPublisher<FriendsListViewState, Never>
}

// MARK: ViewState
enum FriendsListViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case apiSuccess(response: FriendsListResponseModel?)
}

// MARK: FriendsListViewModelType
protocol FriendsListViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FriendsListViewModelInput) -> FriendsListViewModelOutput
}
