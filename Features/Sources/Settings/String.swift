extension String {
    var masked: String? {
        guard let first = first else {
            return nil
        }
        return "\(first)***"
    }
}
