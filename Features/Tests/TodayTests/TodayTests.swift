import APIClient
import ComposableArchitecture
import Foundation
import Models
import Testing
@testable import Today

@MainActor
struct TodayTests {
    @Test
    func successfulFetch() async throws {
        let store = TestStore(
            initialState: TodayReducer.State()
        ) {
            TodayReducer()
        }

        let mock = AstronomyPicture.mockImage()
        store.dependencies.apiClient.apod = { mock }

        await store.send(.fetch) {
            $0.isLoading = true
        }

        await store.receive(\.response.success) {
            $0.isLoading = false
            $0.picture = mock
        }
    }

    @Test
    func failedFetch() async throws {
        let store = TestStore(
            initialState: TodayReducer.State()
        ) {
            TodayReducer()
        }

        let error = NSError(domain: "test", code: 1)
        store.dependencies.apiClient.apod = { throw error }

        await store.send(.fetch) {
            $0.isLoading = true
        }

        await store.receive(\.response.failure) {
            $0.error = .init(error.localizedDescription)
            $0.isLoading = false
        }
    }
}

extension AstronomyPicture {
    static func mockImage() -> Self {
        .init(
            copyright: "copyright",
            date: "2021-07-12",
            explanation: "explanation",
            hdURL: "hdURL",
            mediaType: "image",
            title: "title",
            url: "url"
        )
    }

    static func mockVideo() -> Self {
        .init(
            copyright: "copyright",
            date: "2021-07-12",
            explanation: "explanation",
            hdURL: nil,
            mediaType: "video",
            title: "title",
            url: "url"
        )
    }
}
