import AVFoundation

class AudioBufferManager {
    private var player: AVPlayer?
    private var isPlayingBufferedAudio = false
    private var bufferTime: CMTime = CMTime(seconds: 5, preferredTimescale: 1) // 5 secondi di buffer

    init(streamURL: URL) {
        let playerItem = AVPlayerItem(url: streamURL)
        self.player = AVPlayer(playerItem: playerItem)
    }

    func startBuffering() {
        guard let player = player else { return }
        isPlayingBufferedAudio = true
        player.seek(to: bufferTime, toleranceBefore: .zero, toleranceAfter: .zero) // Vai al buffer
        player.play()
    }

    func stopBuffering() {
        guard let player = player else { return }
        isPlayingBufferedAudio = false
        player.pause()
        player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero) // Torna all'inizio
    }

    func toggleBuffering() {
        if isPlayingBufferedAudio {
            stopBuffering()
        } else {
            startBuffering()
        }
    }
}
