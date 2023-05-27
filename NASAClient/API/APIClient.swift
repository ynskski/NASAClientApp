import Dependencies
import Foundation
import XCTestDynamicOverlay

struct APIClient: Sendable {
    var apod: @Sendable () async throws -> AstronomyPicture
}

extension APIClient: TestDependencyKey {
    static let testValue = Self(
        apod: unimplemented("\(Self.self).apod")
    )
}

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

extension APIClient: DependencyKey {
    static let liveValue = APIClient(
        apod: {
            var components = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: API_KEY),
            ]
            
            let (data, _) = try await URLSession.shared.data(from: components.url!)
            return try JSONDecoder().decode(AstronomyPicture.self, from: data)
        }
    )
}
