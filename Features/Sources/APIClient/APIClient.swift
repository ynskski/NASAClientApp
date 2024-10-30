import Dependencies
import DependenciesMacros
import Foundation
import IssueReporting
import Models

@DependencyClient
public struct APIClient: Sendable {
    public var apod: @Sendable () async throws -> AstronomyPicture
}

extension APIClient: TestDependencyKey {
    public static let testValue = Self()
}

public extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
