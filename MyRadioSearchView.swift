import SwiftUI

struct MyRadioSearchView: View {
    @State private var radioURL: String = ""
    @State private var showRadioPlayer: Bool = false

    var body: some View {
        VStack {
            Text("Inserisci l'URL della radio")
                .font(.title2)
                .padding()

            TextField("URL Radio", text: $radioURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Bottone per confermare e navigare
            NavigationLink(
                destination: {
                    if let validURL = URL(string: radioURL) {
                        MyRadioPlayerView(streamURL: validURL)
                    } else {
                        Text("URL non valido")
                            .foregroundColor(.red)
                            .padding()
                    }
                },
                label: {
                    Text("Cerca")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            )
            .padding()

            Spacer()
        }
        .padding()
    }
}
