//
//  CounterView.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>

    var body: some View {
        VStack(spacing: 24) {
            Text("\(store.count)")
                .font(.system(size: 64, weight: .bold))

            HStack(spacing: 20) {
                Button {
                    store.send(.decrementButtonTapped)
                } label: {
                    Image(systemName: "minus")
                        .font(.title)
                        .frame(width: 30, height: 30)
                }

                Button {
                    store.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .frame(width: 30, height: 30)
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                store.send(.resetButtonTapped)
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
