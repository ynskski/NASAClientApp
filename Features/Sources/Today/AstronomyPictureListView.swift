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
            VStack(alignment: .leading) {
                Text(picture.date.description)
                    .font(.callout)
                    .foregroundStyle(Color.gray)
                Text(picture.title)
            }
        }
        .redacted(reason: store.isLoading ? .placeholder : [])
    }
    
    private func errorRetryView(error: TextState) -> some View {
        Section(
            header: VStack(spacing: 8) {
                Text("⛔")
                    .font(.largeTitle)
                    .padding()

                Text(error)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                Button("Retry", action: { store.send(.fetch) })
                    .font(.callout)
            }
            .textCase(nil)
            .frame(maxWidth: .infinity)
            .padding()
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
