import Settings
import SwiftUI
import Today

public struct AppView: View {
    public var body: some View {
        TabView {
            NavigationStack {
                TodayView(
                    store: .init(
                        initialState: TodayReducer.State()
                    ) {
                        TodayReducer()
                    }
                )
            }
            .tabItem {
                VStack {
                    Image(systemName: "moon.stars")
                    Text("Today")
                }
            }
            
            SettingsView(
                store: .init(
                    initialState: Settings.State()
                ) {
                    Settings()
                }
            )
            .tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
    
    public init() {}
}
