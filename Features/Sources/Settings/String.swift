extension String {
    var masked: String? {
        guard let first else {
            return nil
        }
        return "\(first)***"
    }
}
