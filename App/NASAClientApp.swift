import Features
import SwiftUI
import XCTestDynamicOverlay

@main
struct NASAClientApp: App {
    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                AppView()
            }
        }
    }
}
