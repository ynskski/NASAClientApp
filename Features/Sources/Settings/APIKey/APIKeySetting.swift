import APIClient
import APIKeyClient
import ComposableArchitecture
import Models

@Reducer
public struct APIKeySetting {
    public struct State: Equatable {
        var apiKeyInput: APIKey
        var initialAPIKey: APIKey

        var isEdited: Bool {
            apiKeyInput != initialAPIKey
        }

        public init(
            apiKeyInput: APIKey = .init(rawValue: "")
        ) {
            self.apiKeyInput = apiKeyInput
            initialAPIKey = apiKeyInput
        }
    }

    public enum Action: Equatable {
        case onAppear
        case setAPIKeyInput(String)
        case updateButtonTapped
    }

    @Dependency(\.apiKeyClient) private var apiKeyClient

    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            state.apiKeyInput = apiKeyClient.getKey() ?? .init(rawValue: "")
            return .none

        case let .setAPIKeyInput(input):
            state.apiKeyInput = .init(rawValue: input)
            return .none

        case .updateButtonTapped:
            apiKeyClient.setKey(state.apiKeyInput)
            return .none
        }
    }
}
