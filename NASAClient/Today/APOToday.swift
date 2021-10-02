import ComposableArchitecture
import Foundation

// TODO: Separate image loading state.
struct APOTodayState: Equatable {
    var isLoading = false
    var isLoadingImage = false
    var picture: AstronomyPicture?
    var imageData: Data?
    var error: APIClientError?
}

enum APOTodayAction: Equatable {
    case fetch
    case loadImage
    case response(Result<AstronomyPicture, APIClientError>)
    case imageResponse(Result<Data, APIClientError>)
}

struct APODTodayEnvironment {
    var client: APIClient
    var imageLoader: ImageLoader
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
        return .init(value: .loadImage)
    
    case let .response(.failure(error)):
        state.isLoading = false
        state.error = error
        return .none
        
    case .loadImage:
        if state.picture?.mediaType == "video" {
            return .none
        }
        state.isLoadingImage = true
        return environment.imageLoader.load(from: URL(string: state.picture!.url)!)
            .receive(on: environment.mainQueue)
            .catchToEffect(APOTodayAction.imageResponse)
        
    case let .imageResponse(.success(data)):
        state.isLoadingImage = false
        state.imageData = data
        return .none
        
    case let .imageResponse(.failure(error)):
        state.isLoadingImage = false
        state.error = error
        return .none
    }
}
