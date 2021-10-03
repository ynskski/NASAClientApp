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

func throwErrorForResponse(_ response: URLResponse) throws {
    if let response = response as? HTTPURLResponse {
        if !(200 ..< 300).contains(response.statusCode) {
            throw APIError.unexpectedStatusCode(response.statusCode)
        }
    }
}
