import SwiftUI

struct APIKeyView: View {
    var body: some View {
        List {
            Section(footer: link) {
                TextField("Set your API key", text: .constant(""))
                    .textFieldStyle(.plain)
            }
        }
        .navigationTitle("API key")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {}) {
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
            APIKeyView()
        }
    }
}
