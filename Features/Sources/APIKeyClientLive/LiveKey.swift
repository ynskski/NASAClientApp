import APIKeyClient
import Dependencies
@preconcurrency import KeychainAccess
import Models

extension APIKeyClient: DependencyKey {
    public static let liveValue: Self = .liveValue(service: "dev.ynskski.NASAClient")

    static func liveValue(service: String) -> APIKeyClient {
        let keychain = Keychain(service: service)

        return .init(
            getKey: {
                keychain["APIKey"].map(APIKey.init(rawValue:))
            },
            setKey: {
                keychain.accessibility(.whenUnlockedThisDeviceOnly)["APIKey"] = $0?.rawValue
            }
        )
    }
}
