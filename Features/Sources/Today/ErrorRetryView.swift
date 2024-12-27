import ComposableArchitecture
import SwiftUI

struct ErrorRetryView: View {
    let error: TextState
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text("⛔")
                .font(.largeTitle)
                .padding()
            
            Text(error)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Button("Retry", action: retry)
                .font(.callout)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
