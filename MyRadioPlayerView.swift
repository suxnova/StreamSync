import SwiftUI
import AVKit

struct MyRadioPlayerView: View {
    let streamURL: URL
    @State private var player: AVPlayer?
    @State private var videoStartTime: CMTime?
    @State private var audioStartTime: CMTime?
    @State private var isPlaying = false
    @State private var isBuffering = false
    @State private var fineTuningEnabled = false // Per attivare il fine-tuning dopo il punto 0 video

    var body: some View {
        VStack {
            Text("Stai ascoltando:")
                .font(.headline)
                .padding()

            Text("\(streamURL.absoluteString)")
                .foregroundColor(.purple)
                .padding()

            // Play/Stop Button
            Button(action: {
                if player == nil {
                    player = AVPlayer(url: streamURL)
                }
                if isPlaying {
                    player?.pause()
                } else {
                    player?.play()
                }
                isPlaying.toggle()
            }) {
                Text(isPlaying ? "Stop" : "Play")
                    .foregroundColor(.white)
                    .padding()
                    .background(isPlaying ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            .padding()

            // Buffer Button
            Button(action: {
                if !isBuffering {
                    // Salva il punto 0 dell'audio
                    audioStartTime = player?.currentTime()
                    isBuffering = true
                } else if let audioTime = audioStartTime {
                    // Salva il punto 0 del video e riavvia l'audio sincronizzato
                    videoStartTime = audioTime
                    player?.seek(to: audioTime)
                    player?.play()
                    isBuffering = false
                    fineTuningEnabled = true // Attiva il fine-tuning
                }
            }) {
                Text(isBuffering ? "Set Video Point" : "Set Audio Point")
                    .foregroundColor(.white)
                    .padding()
                    .background(isBuffering ? Color.blue : Color.orange)
                    .cornerRadius(10)
            }
            .padding()

            // Fine-tuning Buttons (attivi solo dopo Set Video Point)
            if fineTuningEnabled {
                HStack {
                    Button(action: {
                        adjustAudio(by: -0.5) // Riduce di 0,5 secondi
                    }) {
                        Text("-0.5s")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        adjustAudio(by: 0.5) // Aumenta di 0,5 secondi
                    }) {
                        Text("+0.5s")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Text("Fine-tuning attivo")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .onAppear {
            player = AVPlayer(url: streamURL)
        }
    }

    // Funzione per regolare l'audio di +/- 0.5 secondi
    private func adjustAudio(by seconds: Double) {
        guard let player = player else { return }
        let currentAudioTime = player.currentTime().seconds
        let adjustedTime = CMTime(seconds: currentAudioTime + seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: adjustedTime)
        player.play()
    }
}
