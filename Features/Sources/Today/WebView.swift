import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: .init(string: "https://www.youtube.com/embed/V_Kd4YBNs7c?rel=0")!)
    }
}
