import Settings
import SwiftUI
import Today

public struct AppView: View {
    public var body: some View {
        TabView {
            NavigationView {
                TodayView(
                    store: .init(
                        initialState: .init(),
                        reducer: TodayReducer()
                    )
                )
            }
            .tabItem {
                VStack {
                    Image(systemName: "moon.stars")
                    Text("Today")
                }
            }
            
            NavigationView {
                SettingsView()
            }
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
