import ComposableArchitecture
import Models
import SwiftUI

struct AstronomyPictureListView: View {
    let store: StoreOf<AstronomyPictureList>

    var body: some View {
        List {
            if let error = store.error {
                errorRetryView(error: error)
            } else {
                content
            }
        }
        .onAppear {
            store.send(.fetch)
        }
        .navigationTitle(.init("Astronomy Pictures"))
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var content: some View {
        ForEach(
            store.isLoading ? AstronomyPicture.placeholderList : store.pictures,
            id: \.date.description
        ) { picture in
            NavigationLink {
                List {
                    AstronomyPictureDetailView(picture: picture)
                }
                .navigationTitle(.init(picture.date.description))
                .navigationBarTitleDisplayMode(.inline)
            } label: {
                VStack(alignment: .leading) {
                    Text(picture.date.description)
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                    Text(picture.title)
                }
            }
            .disabled(!store.isLoaded)
        }
        .redacted(reason: store.isLoading ? .placeholder : [])
    }

    private func errorRetryView(error: TextState) -> some View {
        Section(
            header: ErrorRetryView(
                error: error,
                retry: { store.send(.fetch) }
            )
            .textCase(nil)
        ) {}
    }
}

private extension AstronomyPicture {
    static let placeholderList: [AstronomyPicture] = (0...10).map {
        .init(
            date: .init(year: 2025, month: 1, day: 1).addingMonths($0),
            explanation: "",
            mediaType: .image,
            title: String(repeating: " ", count: .random(in: 10...50))
        )
    }
}
