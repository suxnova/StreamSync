import SwiftUI
import WebKit

struct TwitchPlayerMainView: View {
    var channelName: String

    var body: some View {
        VStack {
            Text("Stai guardando il canale:")
                .font(.headline)
                .padding()

            Text(channelName)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.purple)
                .padding()

            TwitchWebView(channelName: channelName)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Twitch Player")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TwitchWebView: UIViewRepresentable {
    var channelName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = URL(string: "https://www.twitch.tv/\(channelName)")!
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
