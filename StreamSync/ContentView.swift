import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Seleziona la fonte")
                    .font(.largeTitle)
                    .padding()

                // Icona Twitch cliccabile
                NavigationLink(destination: TwitchSearchView()) {
                    VStack {
                        Image(systemName: "video.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)
                        Text("Twitch")
                            .font(.headline)
                            .foregroundColor(.purple)
                    }
                }
                .padding()

                // Icona Radio cliccabile
                NavigationLink(destination: MyRadioSearchView()) {
                    VStack {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        Text("Radio")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
        }
    }
}
