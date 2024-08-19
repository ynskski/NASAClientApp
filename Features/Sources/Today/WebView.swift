import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context _: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: .init(string: "https://www.youtube.com/embed/V_Kd4YBNs7c?rel=0")!)
    }
}
