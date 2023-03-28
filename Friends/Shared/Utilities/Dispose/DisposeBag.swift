//
//  DisposeBag.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//


import Foundation
import Combine

final class DisposeBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    
    func store(in disposeBag: DisposeBag) {
        disposeBag.subscriptions.insert(self)
    }
}
