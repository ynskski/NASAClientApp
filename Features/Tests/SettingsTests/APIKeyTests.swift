import Models
import Testing

@testable import Settings

struct APIKeyTests {
    @Test
    func masked() {
        var key = APIKey(rawValue: "")
        #expect(key.masked == nil)

        key = .init(rawValue: "test")
        #expect(key.masked == "t***")
    }
}
