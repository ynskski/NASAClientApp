import SwiftUI

struct FullScreenImageView: View {
    let image: Image
    @Binding var isPresentedFulScreenImageView: Bool

    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack {
                HStack {
                    Spacer()

                    Button(action: { isPresentedFulScreenImageView = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }

                Spacer()
            }
        }
    }
}

struct FullScreenImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenImageView(
            image: Image(systemName: "photo"),
            isPresentedFulScreenImageView: .constant(true)
        )
    }
}
