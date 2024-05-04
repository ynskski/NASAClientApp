import Features
import SwiftUI

@main
struct NASAClientApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(initialState: .init()) {
                    AppReducer()
                }
            )
        }
    }
}
