import Foundation

struct APIClientError: LocalizedError, Equatable {
    let error: Error
    let uuid: UUID = .init()

    init(error: Error) {
        self.error = error
    }

    var errorDescription: String? {
        error.localizedDescription
    }

    static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
