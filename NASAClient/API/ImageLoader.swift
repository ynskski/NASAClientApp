import ComposableArchitecture
import Foundation

struct ImageLoader {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func load(from url: URL) -> Effect<Data, APIClientError> {
        session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                try throwErrorForResponse(response)
                return data
            }
            .mapError(APIClientError.init)
            .eraseToEffect()
    }
}
