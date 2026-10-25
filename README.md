# TCAPractice

SwiftUI와 **The Composable Architecture(TCA)** 를 학습하기 위해 만든 Counter 앱 실습 프로젝트입니다.

동일한 Counter 기능을 MVVM과 TCA로 구현하며 두 아키텍처의 상태 관리 및 이벤트 처리 방식을 비교하고, TCA의 **Effect, Dependency, TestStore**를 직접 사용해 보는 것을 목표로 했습니다.

## 🛠 기술 스택

- **Language:** Swift
- **UI:** SwiftUI
- **Architecture:** MVVM, TCA
- **State Management:** Observation (`@Observable`), TCA
- **Asynchronous:** Swift Concurrency (`async/await`)
- **Testing:** Swift Testing, TCA TestStore
- **Dependency Management:** Swift Package Manager (SPM)

## ✨ 구현 기능

| 기능 | 설명 |
|---|---|
| 숫자 증가 | `+` 버튼을 누르면 숫자가 1 증가 |
| 숫자 감소 | `−` 버튼을 누르면 숫자가 1 감소 |
| 숫자 초기화 | Reset 버튼을 누르면 숫자가 0으로 초기화 |
| 랜덤 숫자 가져오기 | 비동기 작업을 통해 1~100 사이의 숫자 가져오기 |
| 로딩 상태 표시 | 비동기 작업 중 로딩 표시 및 중복 요청 방지 |
| 오류 처리 | 숫자 가져오기에 실패하면 오류 메시지 표시 |
| 기능 테스트 | 기본 Counter 기능 및 비동기 성공·실패 테스트 |

랜덤 숫자 가져오기 기능은 실제 서버 대신 `Task.sleep`을 사용하여 네트워크 요청과 비슷한 상황을 구현했습니다. 성공과 실패는 랜덤으로 결정됩니다.

## 🍎 구현 화면

| [PR #1](https://github.com/dudwntjs/TCAPractice/pull/1) · 기본 Counter 구현 | [PR #2](https://github.com/dudwntjs/TCAPractice/pull/2) · 비동기 기능 / [PR #3](https://github.com/dudwntjs/TCAPractice/pull/3) · 테스트 |
|:---:|:---:|
|https://github.com/user-attachments/assets/164e533f-47ee-49e2-b250-6b1c7a0df741| https://github.com/user-attachments/assets/66b19c95-39be-4cf0-8754-ae89231897f2| 


## 📚 학습 내용

### 1. MVVM과 TCA 비교

동일한 Counter 앱을 두 가지 아키텍처로 구현하고 상태 관리 방식의 차이를 비교했습니다.

| 구분 | MVVM | TCA |
|---|---|---|
| 상태 관리 | ViewModel | State |
| 사용자 이벤트 | ViewModel 메서드 호출 | Action 전달 |
| 상태 변경 | ViewModel 내부 로직 | Reducer |
| View 연결 | ViewModel 관찰 | Store 사용 |

### 2. Effect와 Dependency

Counter 앱에 비동기 기능을 추가하면서 TCA의 Effect와 Dependency를 학습했습니다.

- **Effect:** 비동기 작업을 실행하고 결과를 Action으로 전달
- **Dependency:** 외부 작업의 구현을 Reducer와 분리
- **NumberClient:** 숫자를 가져오는 비동기 작업을 별도 타입으로 구성
- **DependencyValues:** NumberClient를 등록하고 필요한 곳에서 사용

실제 실행 환경에서는 랜덤한 숫자 또는 오류를 반환하고, 테스트 환경에서는 원하는 결과를 반환하도록 Dependency를 교체할 수 있게 구현했습니다.

### 3. Swift Testing과 TestStore

TCA의 `TestStore`를 사용하여 Action에 따른 State 변경을 검증했습니다.

**기본 기능 테스트**
- 증가 버튼 클릭 시 `count` 증가
- 감소 버튼 클릭 시 `count` 감소
- Reset 버튼 클릭 시 `count` 초기화

**비동기 기능 테스트**
- 숫자 가져오기 성공 시 `count` 변경
- 숫자 가져오기 실패 시 오류 메시지 저장

`store.send()`로 Action에 따른 상태 변경을 검증하고, `store.receive()`로 Effect에서 전달된 Action과 그 결과를 검증했습니다.

또한 `withDependencies`를 활용해 비동기 작업의 성공과 실패 상황을 직접 설정하여 테스트했습니다.

## 📝 관련 블로그

프로젝트를 구현하면서 학습한 내용을 **총 3편의 블로그 글**로 정리했습니다.

각 글에서는 전체 소스 코드보다는 핵심 코드와 개념을 중심으로 설명하고 있습니다. 구현 과정이나 TCA의 동작 방식이 궁금하다면 아래 글을 참고해 주세요!

**1. [iOS] 같은 Counter를 MVVM과 TCA로 구현해 보기**

[블로그 보러 가기](https://medium.com/@sunyoungju517/ios-%EA%B0%99%EC%9D%80-counter%EB%A5%BC-mvvm%EA%B3%BC-tca%EB%A1%9C-%EA%B5%AC%ED%98%84%ED%95%B4-%EB%B3%B4%EA%B8%B0-59135425e06c?sharedUserId=sunyoungju517)

동일한 Counter 앱을 MVVM과 TCA로 각각 구현하면서 State, Action, Reducer, Store의 역할과 두 아키텍처의 차이를 비교했습니다.

**2. [iOS] Counter를 확장하면서 배우는 TCA Effect & Dependency**

[블로그 보러 가기](https://medium.com/@sunyoungju517/ios-counter%EB%A5%BC-%ED%99%95%EC%9E%A5%ED%95%98%EB%A9%B4%EC%84%9C-%EB%B0%B0%EC%9A%B0%EB%8A%94-tca-effect-dependency-e1b9bdda5c80?sharedUserId=sunyoungju517)

Counter 앱에 랜덤 숫자 가져오기 기능을 추가하면서 Effect를 통한 비동기 처리와 Dependency를 활용한 외부 로직 분리 방법을 정리했습니다.

**3. [iOS] TCA의 TestStore로 테스트하기**

[블로그 보러 가기](https://medium.com/@sunyoungju517/ios-tca%EC%9D%98-teststore%EB%A1%9C-%ED%85%8C%EC%8A%A4%ED%8A%B8%ED%95%98%EA%B8%B0-c40b3e10ae13)

Swift Testing과 TestStore를 사용해 Counter의 기본 기능과 비동기 작업을 테스트하고, MVVM과 TCA의 테스트 방식 차이를 살펴보았습니다.

## 💭 마무리

이번 프로젝트를 통해 MVVM과 TCA를 직접 구현하고 비교하면서 각 아키텍처의 특징을 이해할 수 있었습니다.

MVVM은 단순한 기능을 간결하게 구현하기 좋았고, TCA는 State와 Action, Reducer의 역할을 명확하게 구분하고 비동기 작업과 테스트까지 일관된 구조로 관리할 수 있다는 점이 인상적이었습니다.

어떤 아키텍처가 무조건 더 좋기보다는 **프로젝트의 규모와 복잡도, 팀의 상황에 맞게 적절한 구조를 선택하**는 것이 중요한 것 같네요!!
