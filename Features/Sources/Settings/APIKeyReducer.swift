import API
import ComposableArchitecture

@Reducer
public struct APIKeyReducer {
    public struct State: Equatable {
        var apiKeyInput: APIKey
        
        public init(apiKeyInput: APIKey = .init(rawValue: "")) {
            self.apiKeyInput = apiKeyInput
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
