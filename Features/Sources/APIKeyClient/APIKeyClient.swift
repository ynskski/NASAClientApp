import Dependencies
import DependenciesMacros
import Models

@DependencyClient
public struct APIKeyClient: Sendable {
    public var getKey: @Sendable () -> APIKey?
    public var setKey: @Sendable (APIKey?) -> Void
}

extension APIKeyClient: TestDependencyKey {
    public static let testValue = Self()
}

public extension DependencyValues {
    var apiKeyClient: APIKeyClient {
        get { self[APIKeyClient.self] }
        set { self[APIKeyClient.self] = newValue }
    }
}
