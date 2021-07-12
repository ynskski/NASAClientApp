import Foundation

enum APIError: LocalizedError {
    case unexpectedStatusCode(Int)
    
    var errorDescription: String? {
        switch self {
        case let .unexpectedStatusCode(code):
            return "unexpected status code: \(code)"
        }
    }
}
