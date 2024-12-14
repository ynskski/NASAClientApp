import APIKeyClient
@testable import APIKeyClientLive
import Models
import KeychainAccess
import Testing

struct APIKeyClientLiveTests {
    let keychain = Keychain(service: "test")
    
    init() {
        try! keychain.removeAll()
    }
    
    @Test
    func liveValue() throws {
        let client = APIKeyClient.liveValue(service: "test")
        let key = APIKey(rawValue: "key")
        
        try client.setKey(key)
        #expect(try client.getKey() == key)
        
        try client.setKey(nil)
        #expect(try client.getKey() == nil)
    }
}
