//
//  CounterFeature.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {

    @ObservableState
    struct State: Equatable {
        var count = 0
    }

    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case resetButtonTapped
    }

    var body: Reduce<State, Action> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                return .none

            case .decrementButtonTapped:
                state.count -= 1
                return .none

            case .resetButtonTapped:
                state.count = 0
                return .none
            }
        }
    }
}
