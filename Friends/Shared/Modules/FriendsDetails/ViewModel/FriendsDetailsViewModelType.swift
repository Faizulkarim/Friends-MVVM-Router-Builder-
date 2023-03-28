//
//  FriendsDetailsViewModelType.swift
//  Friends
//
//  Created by Md Faizul karim on 29/3/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: FriendsDetailsViewModelInput
struct FriendsDetailsViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct FriendsDetailsViewModelOutput {
    let viewState: AnyPublisher<FriendsDetailsViewState, Never>
}

// MARK: ViewState
enum FriendsDetailsViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
}

// MARK: FriendsDetailsViewModelType
protocol FriendsDetailsViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FriendsDetailsViewModelInput) -> FriendsDetailsViewModelOutput
}
