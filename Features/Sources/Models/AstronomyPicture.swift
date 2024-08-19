import Foundation

public struct AstronomyPicture: Decodable, Equatable, Sendable {
    public var copyright: String?
    public var date: String
    public var explanation: String
    public var hdURL: String?
    public var mediaType: String
    public var title: String
    public var url: String

    public init(
        copyright: String? = nil,
        date: String,
        explanation: String,
        hdURL: String? = nil,
        mediaType: String,
        title: String,
        url: String
    ) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdURL = hdURL
        self.mediaType = mediaType
        self.title = title
        self.url = url
    }

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

public extension AstronomyPicture {
    var mediaTypeEnum: MediaType {
        if mediaType == "image" {
            return .image
        } else if mediaType == "video" {
            return .video
        }
        return .unknown
    }

    enum MediaType {
        case image
        case video
        case unknown
    }
}
