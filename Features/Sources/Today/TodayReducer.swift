import APIClient
import ComposableArchitecture
import Foundation
import Models

@Reducer
public struct TodayReducer: Sendable {
    @ObservableState
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

    public enum Action {
        case fetch
        case response(Result<AstronomyPicture, any Error>)
    }

    public init() {}

    @Dependency(\.apiClient) private var client

    private enum CancelID { case fetch }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetch:
            state.error = nil
            state.isLoading = true
            state.picture = nil
            return .run { send in
                await send(
                    .response(
                        Result {
                            try await client.apod()
                        }
                    )
                )
            }
            .cancellable(id: CancelID.fetch, cancelInFlight: true)

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
