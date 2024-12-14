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
    func liveValue() {
        let client = APIKeyClient.liveValue(service: "test")
        let key = APIKey(rawValue: "key")
        
        client.setKey(key)
        #expect(client.getKey() == key)
        
        client.setKey(nil)
        #expect(client.getKey() == nil)
    }
}
