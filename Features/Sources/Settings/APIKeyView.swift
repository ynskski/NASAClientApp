import ComposableArchitecture
import SwiftUI

struct APIKeyView: View {
    let store: StoreOf<APIKeyReducer>
    @ObservedObject private var viewStore: ViewStoreOf<APIKeyReducer>
    
    init(store: StoreOf<APIKeyReducer>) {
        self.store = store
        viewStore = .init(store, observe: { $0 })
    }
    
    var body: some View {
        List {
            Section(footer: link) {
                TextField(
                    "Set your API key",
                    text: viewStore.binding(
                        get: \.apiKeyInput.rawValue,
                        send: APIKeyReducer.Action.setAPIKeyInput
                    )
                )
                .textFieldStyle(.plain)
            }
        }
        .navigationTitle("API key")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { viewStore.send(.updateButtonTapped) }) {
                    Text("Update")
                }
            }
        }
    }
    
    private var link: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("You can generate your API key on:")
            Link(
                "NASA Open APIs",
                destination: URL(string: "https://api.nasa.gov/")!
            )
            .font(.caption)
        }
    }
}

struct APIKeyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            APIKeyView(
                store: .init(
                    initialState: APIKeyReducer.State()
                ) {
                    EmptyReducer()
                }
            )
        }
    }
}
