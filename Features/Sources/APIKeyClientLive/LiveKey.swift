import APIKeyClient
import Dependencies
import Models
@preconcurrency import KeychainAccess

extension APIKeyClient: DependencyKey {
    public static let liveValue: Self = .liveValue(service: "dev.ynskski.NASAClient")
    
    static func liveValue(service: String) -> APIKeyClient {
        let keychain = Keychain(service: service)
        
        return .init(
            getKey: {
                try keychain.get("APIKey").map(APIKey.init(rawValue:))
            },
            setKey: {
                if let key = $0 {
                    try keychain.set(key.rawValue, key: "APIKey")
                } else {
                    try keychain.remove("APIKey")
                }
            }
        )
    }
}
