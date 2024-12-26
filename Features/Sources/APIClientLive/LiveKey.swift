import APIClient
import APIKeyClient
import APIKeyClientLive
import Dependencies
import Foundation
import Models

extension APIClient: DependencyKey {
    private static let apiKeyClient = APIKeyClient.liveValue

    public static var liveValue: Self {
        .init(
            fetchTodayPicture: {
                // TODO: use enum for path
                let (data, _) = try await request(to: "apod")
                return try AstronomyPicture(
                    payload: JSONDecoder().decode(AstronomyPicture.Payload.self, from: data)
                )
            }
        )
    }

    private static func request(to path: String) async throws -> (Data, URLResponse) {
        let baseURL = URL(string: "https://api.nasa.gov")!

        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.path = "/planetary/\(path)"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKeyClient.getKey()?.rawValue)
        ]

        return try await URLSession.shared.data(from: urlComponents.url!)
    }
}
