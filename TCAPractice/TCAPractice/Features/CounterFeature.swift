//
//  CounterFeature.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {

    @ObservableState
    struct State: Equatable {
        var count = 0
        var isLoading = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        case incrementButtonTapped
        case decrementButtonTapped
        case resetButtonTapped

        case fetchNumberButtonTapped
        case numberResponse(Result<Int, NumberError>)
    }

    @Dependency(\.numberClient) var numberClient

    var body: some Reducer<State, Action> {
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

            case .fetchNumberButtonTapped:
                guard !state.isLoading else {
                    return .none
                }

                state.isLoading = true
                state.errorMessage = nil

                return .run { [numberClient] send in
                    do {
                        let number = try await numberClient.fetch()
                        await send(.numberResponse(.success(number)))
                    } catch {
                        await send(.numberResponse(.failure(.failed)))
                    }
                }

            case let .numberResponse(.success(number)):
                state.isLoading = false
                state.count = number
                return .none

            case let .numberResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none
            }
        }
    }
}
