//
//  CancelBag.swift
//  Ass3_ExpensePlanner
//
//  Created by Jaipreet  on 12/05/24.
//

import Foundation
import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
