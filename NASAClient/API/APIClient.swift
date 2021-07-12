import Combine
import Foundation

final class APIClient {
    private let session: URLSession
    private let baseURL = URL(string: "https://api.nasa.gov")!
    
    init(session: URLSession) {
        self.session = session
    }
    
    private convenience init() {
        let config = URLSessionConfiguration.default
        let session = URLSession(
            configuration: config,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        self.init(session: session)
    }
}
