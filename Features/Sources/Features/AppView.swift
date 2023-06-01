import SwiftUI
import Today

public struct AppView: View {
    public var body: some View {
        NavigationView {
            APODView(
                store: .init(
                    initialState: .init(),
                    reducer: APODReducer()
                )
            )
        }
    }
    
    public init() {}
}
