import ComposableArchitecture

struct APOTodayState: Equatable {
    var isLoading = false
    var picture: AstronomyPicture?
    var error: APIClientError?
}

enum APOTodayAction: Equatable {
    case fetch
    case response(Result<AstronomyPicture, APIClientError>)
}

struct APODTodayEnvironment {
    var client: APIClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let APOTodayReducer = Reducer<
    APOTodayState,
    APOTodayAction,
    APODTodayEnvironment
> { state, action, environment in
    switch action {
    case .fetch:
        state.isLoading = true
        return environment.client.apod()
            .receive(on: environment.mainQueue)
            .catchToEffect(APOTodayAction.response)
        
    case let .response(.success(picture)):
        state.isLoading = false
        state.picture = picture
        return .none
    
    case let .response(.failure(error)):
        state.isLoading = false
        state.error = error
        return .none
    }
}
