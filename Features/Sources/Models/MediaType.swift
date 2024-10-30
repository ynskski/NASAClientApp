public enum MediaType: Sendable {
    case image
    case video
    case other
    case unknown
    
    init(string: String) {
        switch string {
        case "image":
            self = .image
        case "video":
            self = .video
        case "other":
            self = .other
        default:
            self = .unknown
        }
    }
}
