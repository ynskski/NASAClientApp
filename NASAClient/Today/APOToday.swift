import ComposableArchitecture
import Foundation

struct APODReducer: ReducerProtocol {
    struct State: Equatable {
        var error: TextState?
        var isLoading = false
        var picture: AstronomyPicture?
    }
    
    enum Action: Equatable {
        case fetch
        case response(TaskResult<AstronomyPicture>)
    }
    
    @Dependency(\.apiClient) private var client
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
