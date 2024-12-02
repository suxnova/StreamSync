import SwiftUI

struct TwitchSearchView: View {
    @State private var channelName: String = "" // Nome del canale inserito
    @State private var showTwitchPlayer = false // Per passare alla schermata del player

    var body: some View {
        VStack {
            Text("Inserisci il nome del canale Twitch")
                .font(.title2)
                .padding()

            // Campo di testo per il nome del canale
            TextField("Nome canale", text: $channelName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Bottone per confermare
            Button(action: {
                showTwitchPlayer = true
            }) {
                Text("Cerca")
                    .font(.headline)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .background(
            NavigationLink(destination: TwitchPlayerMainView(channelName: channelName), isActive: $showTwitchPlayer) {
                EmptyView()
            }
        )
    }
}

struct TwitchSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TwitchSearchView()
    }
}
