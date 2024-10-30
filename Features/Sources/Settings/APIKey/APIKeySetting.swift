import APIClient
import APIClientLive
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
            apiKeyInput: APIKey = APIClient.apiKey ?? .init(rawValue: "")
        ) {
            self.apiKeyInput = apiKeyInput
            initialAPIKey = apiKeyInput
        }
    }

    public enum Action: Equatable {
        case setAPIKeyInput(String)
        case updateButtonTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .setAPIKeyInput(input):
            state.apiKeyInput = .init(rawValue: input)
            return .none

        case .updateButtonTapped:
            // TODO: Persist API key
            APIClient.setAPIKey(state.apiKeyInput)
            return .none
        }
    }
}
