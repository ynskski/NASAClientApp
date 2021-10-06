import Foundation

struct AstronomyPicture: Decodable, Equatable {
    var copyright: String?
    var date: String
    var explanation: String
    var hdURL: String?
    var mediaType: String
    var title: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdURL = "hdurl"
        case mediaType = "media_type"
        case title
        case url
    }
}

extension AstronomyPicture {
    static func mockImage() -> Self {
        .init(
            copyright: "copyright",
            date: "2021-07-12",
            explanation: "explanation",
            hdURL: "hdURL",
            mediaType: "image",
            title: "title",
            url: "url"
        )
    }
}
