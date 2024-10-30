import Foundation
import LocalDate
import Testing

@testable import Models

@MainActor
struct AstronomyPictureTests {
    @Test
    func initFromPayload() {
        let payload = AstronomyPicture.Payload(
            copyright: "copyright",
            date: "2024-01-01",
            explanation: "explanation",
            hdURL: "https://example.com/hd-url",
            mediaType: "image",
            title: "title",
            url: "https://example.com/url"
        )

        let model = AstronomyPicture(
            copyright: "copyright",
            date: LocalDate(year: 2024, month: 1, day: 1),
            explanation: "explanation",
            hdURL: URL(string: "https://example.com/hd-url")!,
            mediaType: .image,
            title: "title",
            url: URL(string: "https://example.com/url")!
        )

        #expect(AstronomyPicture(payload: payload) == model)
    }
}
