import SwiftUI
import Today

public struct AppView: View {
    public var body: some View {
        NavigationView {
            TodayView(
                store: .init(
                    initialState: .init(),
                    reducer: TodayReducer()
                )
            )
        }
    }
    
    public init() {}
}
