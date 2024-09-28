import Dependencies
import DependenciesMacros
import Foundation
import Models
import IssueReporting

@DependencyClient
public struct APIClient: Sendable {
    public var apod: @Sendable () async throws -> AstronomyPicture
}

extension APIClient: TestDependencyKey {
    public static let testValue = Self(
        apod: unimplemented("\(Self.self).apod")
    )
}

public extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

extension APIClient: DependencyKey {
    nonisolated(unsafe) public private(set) static var apiKey: APIKey?

    public static let liveValue = APIClient(
        apod: {
            var components = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey?.rawValue),
            ]

            let (data, _) = try await URLSession.shared.data(from: components.url!)
            return try JSONDecoder().decode(AstronomyPicture.self, from: data)
        }
    )

    public static func setAPIKey(_ key: APIKey) {
        apiKey = key
    }
}
