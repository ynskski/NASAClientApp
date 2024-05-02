import SwiftUI

struct LanguageView: View {
    var body: some View {
        List {
            Text("English")
            Text("Japanese")
        }
        .navigationTitle("Language")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LanguageView()
        }
    }
}
