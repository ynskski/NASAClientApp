extension String {
    var masked: String? {
        guard let first = self.first else {
            return nil
        }
        return "\(first)***"
    }
}
