//
//  CounterViewModel.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import Observation

@Observable
final class CounterViewModel {
    private(set) var count = 0

    func increment() {
        count += 1
    }

    func decrement() {
        count -= 1
    }

    func reset() {
        count = 0
    }
}
