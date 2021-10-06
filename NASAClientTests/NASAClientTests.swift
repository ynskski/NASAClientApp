import ComposableArchitecture
@testable import NASAClient
import XCTest

class NASAClientTests: XCTestCase {
    let store = TestStore(
        initialState: APOTodayState(),
        reducer: APOTodayReducer,
        environment: APODTodayEnvironment(
            client: .init(session: .shared),
            imageLoader: .init(session: .shared),
            mainQueue: .main
        )
    )

    func test_flow_fetch_image_success() {
        store.send(.fetch) {
            $0.isLoading = true
        }

        store.send(.response(.success(.mockImage()))) {
            $0.isLoading = false
            $0.picture = .mockImage()
        }

        store.receive(.loadImage) {
            $0.isLoadingImage = true
        }

        store.send(.imageResponse(.success(.init()))) {
            $0.isLoadingImage = false
            $0.imageData = .init()
        }
    }

    func test_flow_fetch_image_failure() {
        store.send(.fetch) {
            $0.isLoading = true
        }

        store.send(.response(.success(.mockImage()))) {
            $0.isLoading = false
            $0.picture = .mockImage()
        }

        store.receive(.loadImage) {
            $0.isLoadingImage = true
        }

        let mockError: APIClientError = .mock()
        store.send(.imageResponse(.failure(mockError))) {
            $0.isLoadingImage = false
            $0.error = mockError
        }
    }

    func test_flow_fetch_video_success() {
        store.send(.fetch) {
            $0.isLoading = true
        }

        store.send(.response(.success(.mockVideo()))) {
            $0.isLoading = false
            $0.picture = .mockVideo()
        }

        // Unimplemented processing video url.
        store.receive(.loadImage)
    }

    func test_flow_fetch_failure() {
        store.send(.fetch) {
            $0.isLoading = true
        }

        let mockError: APIClientError = .mock()
        store.send(.response(.failure(mockError))) {
            $0.isLoading = false
            $0.error = mockError
        }
    }
}
