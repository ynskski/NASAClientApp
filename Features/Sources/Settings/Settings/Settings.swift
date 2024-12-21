import APIKeyClient
import ComposableArchitecture
import Models

@Reducer
public struct Settings {
    @Reducer(state: .equatable)
    public enum Path {
        case apiKeySetting(APIKeySetting)
    }

    @ObservableState
    public struct State: Equatable {
        var apiKey: APIKey
        var path = StackState<Path.State>()

        public init(
            apiKey: APIKey = .init(rawValue: "")
        ) {
            self.apiKey = apiKey
        }
    }

    public enum Action {
        case onAppear
        case path(StackActionOf<Path>)
        case popToRoot
    }

    @Dependency(\.apiKeyClient) private var apiKeyClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.apiKey = apiKeyClient.getKey() ?? .init(rawValue: "")
                return .none

            case let .path(action):
                switch action {
                case let .element(id: id, action: .apiKeySetting(.delegate(.updated))):
                    state.apiKey = apiKeyClient.getKey() ?? .init(rawValue: "")
                    state.path.pop(from: id)
                    return .none

                default:
                    return .none
                }

            case .popToRoot:
                state.path.removeAll()
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

    public init() {}
}
