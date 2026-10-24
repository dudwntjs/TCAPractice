//
//  TCAPracticeApp.swift
//  TCAPractice
//
//  Created by sun on 10/17/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(initialState: CounterFeature.State()) {
                    CounterFeature()
                }
            )
        }
    }
}
