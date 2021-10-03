import Combine
import ComposableArchitecture
import Foundation

final class APIClient {
    private let session: URLSession
    private let baseURL = "https://api.nasa.gov"

    init(session: URLSession) {
        self.session = session
    }

    private convenience init() {
        let config = URLSessionConfiguration.default
        let session = URLSession(
            configuration: config,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        self.init(session: session)
    }

    func apod() -> Effect<AstronomyPicture, APIClientError> {
        var urlComponents = URLComponents(string: "\(baseURL)/planetary/apod")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
        ]

        return session.dataTaskPublisher(for: urlComponents.url!)
            .tryMap { data, response in
                try throwErrorForResponse(response)
                return data
            }
            .decode(type: AstronomyPicture.self, decoder: JSONDecoder())
            .mapError(APIClientError.init)
            .eraseToEffect()
    }
}
