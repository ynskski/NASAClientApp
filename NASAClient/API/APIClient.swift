import Combine
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
    
    func apod() -> AnyPublisher<AstronomyPicture, Error> {
        var urlComponents = URLComponents(string: "\(baseURL)/planetary/apod")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        
        return session.dataTaskPublisher(for: urlComponents.url!)
            .mapError{ $0 as Error }
            .tryMap { data, response in
                try throwErrorForResponse(response)
                return data
            }
            .decode(type: AstronomyPicture.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

private func throwErrorForResponse(_ response: URLResponse) throws {
    if let response = response as? HTTPURLResponse {
        if !(200..<300).contains(response.statusCode) {
            throw APIError.unexpectedStatusCode(response.statusCode)
        }
    }
}
