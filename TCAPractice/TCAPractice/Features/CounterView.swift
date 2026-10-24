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
                        .frame(width: 60, height: 60)
                }

                Button {
                    store.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .frame(width: 60, height: 60)
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                store.send(.resetButtonTapped)
            }
            .buttonStyle(.bordered)

            Divider()

            Button {
                store.send(.fetchNumberButtonTapped)
            } label: {
                HStack {
                    if store.isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "dice")
                    }

                    Text(
                        store.isLoading
                        ? "숫자를 가져오는 중..."
                        : "랜덤 숫자 가져오기"
                    )
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(store.isLoading)

            if let errorMessage = store.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
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
