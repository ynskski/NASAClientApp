import APIClient
import ComposableArchitecture
import LicenseList
import SwiftUI

public struct SettingsView: View {
    @Bindable var store: StoreOf<Settings>

    public init(store: StoreOf<Settings>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                Section {
                    NavigationLink(
                        state: Settings.Path.State.apiKeySetting(
                            APIKeySetting.State()
                        )
                    ) {
                        HStack {
                            NavigationLinkLabel(
                                color: .yellow,
                                text: Text("API Key"),
                                icon: Image(systemName: "key.fill")
                            )

                            Spacer()

                            Text(APIClient.apiKey?.rawValue.masked ?? "None")
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }

                Section {
                    NavigationLink {
                        LanguageView()
                    } label: {
                        NavigationLinkLabel(
                            color: .green,
                            text: Text("Language"),
                            icon: Image(systemName: "globe")
                        )
                    }

                    NavigationLink {
                        Text("Appearance")
                    } label: {
                        NavigationLinkLabel(
                            color: .cyan,
                            text: Text("Appearance"),
                            icon: Image(systemName: "circle.lefthalf.filled")
                        )
                    }
                }

                Section {
                    NavigationLink {
                        LicenseListView()
                            .licenseViewStyle(.withRepositoryAnchorLink)
                            .navigationTitle(.init("Acknowledgement"))
                    } label: {
                        NavigationLinkLabel(
                            color: .gray,
                            text: Text("Acknowledgement"),
                            icon: Image(systemName: "wrench.and.screwdriver")
                        )
                    }
                }
            }
            .navigationTitle("Settings")
        } destination: { store in
            switch store.case {
            case let .apiKeySetting(store):
                APIKeySettingView(store: store)
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView(
            store: .init(
                initialState: Settings.State()
            ) {
                EmptyReducer()
            }
        )
    }
}
