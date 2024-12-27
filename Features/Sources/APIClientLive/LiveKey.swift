import APIClient
import APIKeyClient
import APIKeyClientLive
import Dependencies
import Foundation
import LocalDate
import Models

extension APIClient: DependencyKey {
    private static let apiKeyClient = APIKeyClient.liveValue
    private static let baseURL = URL(string: "https://api.nasa.gov")!

    // TODO: API request abstraction
    public static var liveValue: Self {
        .init(
            fetchAstronomyPictures: {
                var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
                urlComponents.path = "/planetary/apod"
                urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: apiKeyClient.getKey()?.rawValue),
                    URLQueryItem(
                        name: "start_date",
                        value: LocalDate().addingMonths(-1).description
                    ),
                ]

                let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)

                return try JSONDecoder()
                    .decode([AstronomyPicture.Payload].self, from: data)
                    .map(AstronomyPicture.init)
                    .reversed()
            },
            fetchTodayPicture: {
                var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
                urlComponents.path = "/planetary/apod"
                urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: apiKeyClient.getKey()?.rawValue)
                ]

                let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)

                return try AstronomyPicture(
                    payload: JSONDecoder().decode(AstronomyPicture.Payload.self, from: data)
                )
            }
        )
    }
}
