import APIClient
import ComposableArchitecture
import Foundation
import LocalDate
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
            date: LocalDate(year: 2012, month: 7, day: 12),
            explanation: "explanation",
            hdURL: URL(string: "https://example.com/hd-url")!,
            mediaType: .image,
            title: "title",
            url: URL(string: "https://example.com/url")!
        )
    }

    static func mockVideo() -> Self {
        .init(
            copyright: "copyright",
            date: LocalDate(year: 2012, month: 7, day: 12),
            explanation: "explanation",
            hdURL: nil,
            mediaType: .video,
            title: "title",
            url: URL(string: "https://example.com")!
        )
    }
}
