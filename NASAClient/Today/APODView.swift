import ComposableArchitecture
import SwiftUI

struct APODView: View {
    let store: StoreOf<APODReducer>
    @ObservedObject private var viewStore: ViewStoreOf<APODReducer>
    
    @State private var isPresentedFullScreenImage = false
    
    init(store: StoreOf<APODReducer>) {
        self.store = store
        viewStore = .init(store)
    }

    var body: some View {
        List {
            if let error = viewStore.error {
                errorRetryView(error: error)
            } else {
                content
            }
        }
        .onAppear {
            if viewStore.picture == nil, !viewStore.isLoading {
                viewStore.send(.fetch)
            }
        }
        .navigationTitle("Today")
    }
    
    @ViewBuilder
    private var content: some View {
        Section (
            header: Text("Picture")
                .textCase(nil)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
        ) {
            if let picture = viewStore.picture {
                switch picture.mediaTypeEnum {
                case .image:
                    AsyncImage(url: .init(string: picture.url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        case let .success(image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    isPresentedFullScreenImage = true
                                }
                                .fullScreenCover(isPresented: $isPresentedFullScreenImage) {
                                    FullScreenImageView(
                                        closeButtonTapped: { isPresentedFullScreenImage = false },
                                        hdImageURL: picture.hdURL.map { URL(string: $0)! },
                                        image: image
                                    )
                                }
                        case let .failure(error):
                            VStack {
                                Text("Failed to open:")
                                Link(picture.url, destination: URL(string: picture.url)!)
                                Text(error.localizedDescription)
                            }
                        @unknown default:
                            Text("Unexpected error occurred.")
                        }
                    }
                case .video:
                    WebView(url: .init(string: picture.url)!)
                        .aspectRatio(contentMode: .fit)
                case .unknown:
                    Text("Unexpected error occurred.")
                }
            } else if let error = viewStore.error {
                errorRetryView(error: error)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }

        Section(
            header: Text("Title")
                .textCase(nil)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
        ) {
            Text(viewStore.picture?.title ?? titlePlaceHolder)
                .font(.body.bold())
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
        }

        Section(
            header: Text("Explanation")
                .textCase(nil)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
        ) {
            Text(viewStore.picture?.explanation ?? explanationPlaceHolder)
                .redacted(reason: viewStore.isLoading ? .placeholder : [])
        }

        if let copyright = viewStore.picture?.copyright {
            Section(
                header: Text("copyright: \(copyright)")
                    .textCase(nil)
                    .redacted(reason: viewStore.isLoading ? .placeholder : [])
            ) {}
        }
    }

    @ViewBuilder
    private func errorRetryView(error: TextState) -> some View {
        Section(
            header: VStack {
                Image(systemName: "xmark.octagon")
                    .imageScale(.large)

                HStack {
                    Text("An Error occured")
                        .foregroundColor(.gray)

                    Button(action: { viewStore.send(.fetch) }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .padding(.horizontal)
                }
                .padding()

                Text(error)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .textCase(nil)
            }
            .frame(maxWidth: .infinity)
            .padding()
        ) {}
    }

    private var titlePlaceHolder: String {
        "M27: The Dumbbell Nebula"
    }

    private var explanationPlaceHolder: String {
        "What will become of our Sun?"
    }
}

struct APOTodayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            APODView(
                store: .init(
                    initialState: .init(
                        error: nil,
                        isLoading: false,
                        picture: .init(
                            copyright: "Bray FallsKeith Quattrocchi",
                            date: "2021-07-12",
                            explanation: "What will become of our Sun? The first hint of our Sun's future was discovered inadvertently in 1764. At that time, Charles Messier was compiling a list of diffuse objects not to be confused with comets. The 27th object on Messier's list, now known as M27 or the Dumbbell Nebula, is a planetary nebula, one of the brightest planetary nebulae on the sky -- and visible toward the constellation of the Fox (Vulpecula) with binoculars. It takes light about 1000 years to reach us from M27, featured here in colors emitted by hydrogen and oxygen. We now know that in about 6 billion years, our Sun will shed its outer gases into a planetary nebula like M27, while its remaining center will become an X-ray hot white dwarf star.  Understanding the physics and significance of M27 was well beyond 18th century science, though. Even today, many things remain mysterious about planetary nebulas, including how their intricate shapes are created.",
                            hdURL: "https://apod.nasa.gov/apod/image/2107/M27_Falls_3557.jpg",
                            mediaType: "image",
                            title: "M27: The Dumbbell Nebula",
                            url: "https://apod.nasa.gov/apod/image/2107/M27_Falls_960.jpg"
                        )
                    ),
                    reducer: .empty,
                    environment: ()
                )
            )
        }
        .previewDisplayName("画像")

        NavigationView {
            APODView(
                store: .init(
                    initialState: .init(
                        error: nil,
                        isLoading: false,
                        picture: .init(
                            copyright: nil,
                            date: "2021-07-12",
                            explanation: "What happens when a black hole destroys a neutron star? Analyses indicate that just such an event created gravitational wave event GW200115, detected in 2020 January by LIGO and Virgo observatories. To better understand the unusual event, the featured visualization was created from a computer simulation. The visualization video starts with the black hole (about 6 times the Sun's mass) and neutron star (about 1.5 times the Sun's mass) circling each other, together emitting an increasing amount of gravitational radiation. The picturesque pattern of gravitational wave emission is shown in blue. The duo spiral together increasingly fast until the neutron star becomes completely absorbed by the black hole.  Since the neutron star did not break apart during the collision, little light escaped -- which matches the lack of an observed optical counterpart. The remaining black hole rings briefly, and as that dies down so do the emitted gravitational waves.  The 30-second time-lapse video may seem short, but it actually lasts about 1000 times longer than the real merger event.    Astrophysicists: Browse 2,500+ codes in the Astrophysics Source Code Library",
                            hdURL: nil,
                            mediaType: "video",
                            title: "GW200115: Simulation of a Black Hole Merging with a Neutron Star",
                            url: "https://www.youtube.com/embed/V_Kd4YBNs7c?rel=0"
                        )
                    ),
                    reducer: .empty,
                    environment: ()
                )
            )
        }
        .previewDisplayName("動画")
    }
}
