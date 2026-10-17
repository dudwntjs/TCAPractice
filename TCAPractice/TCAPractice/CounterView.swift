//
//  CounterView.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import SwiftUI

struct CounterView: View {
    @State private var viewModel = CounterViewModel()

    var body: some View {
        VStack(spacing: 24) {
            Text("\(viewModel.count)")
                .font(.system(size: 64, weight: .bold))

            HStack(spacing: 20) {
                Button {
                    viewModel.decrement()
                } label: {
                    Image(systemName: "minus")
                        .font(.title)
                        .frame(width: 30, height: 30)
                }

                Button {
                    viewModel.increment()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .frame(width: 30, height: 30)
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                viewModel.reset()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}


#Preview {
    CounterView()
}
