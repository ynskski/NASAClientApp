import Models
import Sharing
import SwiftUI

struct AppearanceView: View {
    @Shared(.appStorage("colorScheme")) var userColorScheme = UserColorScheme.system

    var body: some View {
        Form {
            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .light
                    }
                }
            ) {
                HStack {
                    Text("Light")
                        .foregroundStyle(Color.primary)

                    Spacer()

                    if userColorScheme == .light {
                        Image(systemName: "checkmark")
                    }
                }
            }

            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .dark
                    }
                }
            ) {
                HStack {
                    Text("Dark")
                        .foregroundStyle(Color.primary)

                    Spacer()

                    if userColorScheme == .dark {
                        Image(systemName: "checkmark")
                    }
                }
            }

            Button(
                action: {
                    $userColorScheme.withLock {
                        $0 = .system
                    }
                }
            ) {
                HStack {
                    Text("Automatic")
                        .foregroundStyle(Color.primary)

                    Spacer()

                    if userColorScheme == .system {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
}
