import SwiftUI

struct NavigationLinkLabel: View {
    let color: Color
    let text: Text
    let icon: Image
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 30, height: 30)
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
