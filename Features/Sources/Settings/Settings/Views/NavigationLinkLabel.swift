import SwiftUI

struct NavigationLinkLabel: View {
    let color: Color
    let text: Text
    let icon: Image

    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .font(.largeTitle)
                .foregroundColor(color)
                .overlay {
                    icon
                        .foregroundColor(.white)
                }
                .padding(.trailing, 8)

            text
        }
    }
}
