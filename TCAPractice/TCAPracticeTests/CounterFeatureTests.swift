//
//  TCAPracticeTests.swift
//  TCAPracticeTests
//
//  Created by sun on 10/25/26.
//

import Foundation
import Testing
import ComposableArchitecture

@testable import TCAPractice

@MainActor
struct CounterFeatureTests {

    // MARK: - 기본 기능 테스트

    @Test("증가 버튼을 누르면 count가 1 증가한다")
    func increment() async {
        let store = TestStore(
            initialState: CounterFeature.State()
        ) {
            CounterFeature()
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
    }

    @Test("감소 버튼을 누르면 count가 1 감소한다")
    func decrement() async {
        let store = TestStore(
            initialState: CounterFeature.State()
        ) {
            CounterFeature()
        }

        await store.send(.decrementButtonTapped) {
            $0.count = -1
        }
    }

    @Test("Reset 버튼을 누르면 count가 0이 된다")
    func reset() async {
        var initialState = CounterFeature.State()
        initialState.count = 5

        let store = TestStore(
            initialState: initialState
        ) {
            CounterFeature()
        }

        await store.send(.resetButtonTapped) {
            $0.count = 0
        }
    }

    // MARK: - 비동기 기능 테스트

    @Test("랜덤 숫자 가져오기에 성공하면 count가 변경된다")
    func fetchNumberSuccess() async {
        let store = TestStore(
            initialState: CounterFeature.State()
        ) {
            CounterFeature()
        } withDependencies: {
            $0.numberClient.fetch = { 42 }
        }

        // 버튼 클릭 → 로딩 시작
        await store.send(.fetchNumberButtonTapped) {
            $0.isLoading = true
        }

        // 비동기 작업 성공 → 숫자 변경
        await store.receive(
            .numberResponse(.success(42))
        ) {
            $0.isLoading = false
            $0.count = 42
        }
    }

    @Test("랜덤 숫자 가져오기에 실패하면 오류 메시지가 표시된다")
    func fetchNumberFailure() async {
        let store = TestStore(
            initialState: CounterFeature.State()
        ) {
            CounterFeature()
        } withDependencies: {
            $0.numberClient.fetch = {
                throw NumberError.failed
            }
        }

        // 버튼 클릭 → 로딩 시작
        await store.send(.fetchNumberButtonTapped) {
            $0.isLoading = true
        }

        // 비동기 작업 실패 → 오류 메시지 저장
        await store.receive(
            .numberResponse(.failure(.failed))
        ) {
            $0.isLoading = false
            $0.errorMessage = NumberError.failed.localizedDescription
        }
    }
}
