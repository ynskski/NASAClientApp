import Models

extension APIKey {
    var masked: String? {
        guard let first = rawValue.first else {
            return nil
        }
        return "\(first)***"
    }
}
