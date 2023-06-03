import API
import ComposableArchitecture
import Foundation

public struct TodayReducer: ReducerProtocol {
    public struct State: Equatable {
        var error: TextState?
        var isLoading = false
        var picture: AstronomyPicture?
        
        public init(
            error: TextState? = nil,
            isLoading: Bool = false,
            picture: AstronomyPicture? = nil
        ) {
            self.error = error
            self.isLoading = isLoading
            self.picture = picture
        }
    }
    
    public enum Action: Equatable {
        case fetch
        case response(TaskResult<AstronomyPicture>)
    }
    
    public init() {}
    
    @Dependency(\.apiClient) private var client
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetch:
            state.isLoading = true
            return .task {
                await .response(
                    TaskResult {
                        try await client.apod()
                    }
                )
            }
            
        case let .response(.success(picture)):
            state.isLoading = false
            state.picture = picture
            return .none
            
        case let .response(.failure(error)):
            state.error = .init(error.localizedDescription)
            state.isLoading = false
            return .none
        }
    }
}
