import AstronomyPicture
import ComposableArchitecture
import Settings

@Reducer
public struct AppReducer {
    @ObservableState
    public struct State: Equatable {
        var settings = Settings.State()
        var today = TodayReducer.State()

        public init() {}
    }

    public enum Action {
        case settings(Settings.Action)
        case today(TodayReducer.Action)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            Settings()
        }

        Scope(state: \.today, action: \.today) {
            TodayReducer()
        }
    }
}
