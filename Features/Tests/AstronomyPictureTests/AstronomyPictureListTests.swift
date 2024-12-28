import APIClient
import ComposableArchitecture
import Foundation
import Models
import Testing

@testable import AstronomyPicture

@MainActor
struct AstronomyPictureListTests {
    @Test
    func fetch() async throws {
        let store = TestStore(
            initialState: AstronomyPictureList.State()
        ) {
            AstronomyPictureList()
        }

        store.dependencies.apiClient.fetchAstronomyPictures = {
            [.mockImage()]
        }

        await store.send(.fetch) {
            $0.isLoading = true
        }

        await store.receive(\.response.success, [.mockImage()]) {
            $0.isLoaded = true
            $0.isLoading = false
            $0.pictures = [.mockImage()]
        }

        await store.send(.fetch)
    }

    @Test
    func fetchFailed() async throws {
        let store = TestStore(
            initialState: AstronomyPictureList.State()
        ) {
            AstronomyPictureList()
        }

        let error = NSError(domain: "test", code: 1)
        store.dependencies.apiClient.fetchAstronomyPictures = {
            throw error
        }

        await store.send(.fetch) {
            $0.isLoading = true
        }

        await store.receive(\.response.failure) {
            $0.error = .init(error.localizedDescription)
            $0.isLoading = false
        }
    }
}
