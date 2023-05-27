import ComposableArchitecture
@testable import NASAClient
import XCTest

@MainActor
final class NASAClientTests: XCTestCase {
    func test_fetch() async {
        let store = TestStore(
            initialState: .init(),
            reducer: APODReducer()
        )
        
        let mock = AstronomyPicture.mockImage()
        store.dependencies.apiClient.apod = { mock }
        
        await store.send(.fetch) {
            $0.isLoading = true
        }
        
        await store.receive(.response(.success(mock))) {
            $0.isLoading = false
            $0.picture = mock
        }
    }
    
    func test_fetch_failure() async {
        let store = TestStore(
            initialState: .init(),
            reducer: APODReducer()
        )
        
        let error = NSError(domain: "test", code: 1)
        store.dependencies.apiClient.apod = { AstronomyPicture.mockImage() }
        
        await store.send(.fetch) {
            $0.isLoading = true
        }
        
        await store.receive(.response(.failure(error))) {
            $0.error = .init(error.localizedDescription)
            $0.isLoading = false
        }
    }
}
