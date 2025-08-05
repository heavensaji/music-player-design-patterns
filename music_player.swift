import Foundation
import Combine

// MARK: - Model

/// Represents a song with title, artist, and URL/location
struct Song: Identifiable {
    let id: UUID = UUID()
    let title: String
    let artist: String
    let url: URL
}

/// Playback state enum representing player states
enum PlaybackState {
    case playing
    case paused
    case stopped
}

// MARK: - Music Source Protocol (Strategy Pattern)

/// Protocol defining a music source interface.
/// Allows multiple sources to provide different implementations.
protocol MusicSource {
    /// Loads a song into the source
    func loadSong(url: URL)
    
    /// Starts playing the loaded song
    func play()
    
    /// Pauses the current playback
    func pause()
    
    /// Stops the playback
    func stop()
    
    /// The currently loaded song (if any)
    var currentSong: Song? { get }
}

// MARK: - Local Music Source

/// Local music source implementation simulating local file playback
class LocalMusicSource: MusicSource {
    private(set) var currentSong: Song?
    
    func loadSong(url: URL) {
        // For simulation, we assume the URL contains metadata in the path
        self.currentSong = Song(title: url.lastPathComponent, artist: "Local Artist", url: url)
    }
    
    func play() {
        print("Playing from Local Source: \(currentSong?.title ?? "Unknown")")
    }
    
    func pause() {
        print("Paused Local player")
    }
    
    func stop() {
        print("Stopped Local player")
    }
}

// MARK: - Spotify (Mock) Music Source

/// Mock Spotify music source simulating streaming playback
class SpotifyMusicSource: MusicSource {
    private(set) var currentSong: Song?
    
    func loadSong(url: URL) {
        self.currentSong = Song(title: "Spotify: " + url.lastPathComponent, artist: "Spotify Artist", url: url)
    }
    
    func play() {
        print("Streaming from Spotify: \(currentSong?.title ?? "Unknown")")
    }
    
    func pause() {
        print("Paused Spotify player")
    }
    
    func stop() {
        print("Stopped Spotify player")
    }
}

// MARK: - Music Player (Singleton + Queue + Playback Controls)

/// Singleton MusicPlayer that manages playback states, queue, and source switching
class MusicPlayer {
    static let shared = MusicPlayer()
    
    private init() {}
    
    private var source: MusicSource?
    private(set) var queue: [Song] = []
    private var currentIndex: Int = -1
    
    // Playback state published for observers (simulated Combine usage)
    @Published private(set) var playbackState: PlaybackState = .stopped
    
    var currentSong: Song? {
        guard currentIndex >= 0, currentIndex < queue.count else { return nil }
        return queue[currentIndex]
    }
    
    // Set or switch the music source implementation
    func setSource(_ source: MusicSource) {
        self.source = source
    }
    
    // Add a song to the playback queue
    func addToQueue(_ song: Song) {
        queue.append(song)
    }
    
    // Remove a song from the queue by index
    func removeFromQueue(at index: Int) {
        guard index >= 0, index < queue.count else { return }
        queue.remove(at: index)
        // Adjust currentIndex if needed
        if index <= currentIndex {
            currentIndex = max(-1, currentIndex - 1)
        }
    }
    
    // Reorder songs in the queue
    func moveInQueue(from: Int, to: Int) {
        guard from >= 0, from < queue.count,
              to >= 0, to < queue.count else { return }
        
        let song = queue.remove(at: from)
        queue.insert(song, at: to)
        
        if currentIndex == from {
            currentIndex = to
        } else if currentIndex >= min(from, to) && currentIndex <= max(from, to) {
            // Adjust currentIndex if it falls within the reorder range
            if from < to {
                currentIndex -= 1
            } else {
                currentIndex += 1
            }
        }
    }
    
    // Play the current song or start playback from beginning
    func play() {
        if currentIndex == -1 && !queue.isEmpty {
            currentIndex = 0
        }
        
        guard let song = currentSong else {
            print("No songs to play.")
            return
        }
        
        source?.loadSong(url: song.url)
        source?.play()
        playbackState = .playing
    }
    
    // Pause the player
    func pause() {
        source?.pause()
        playbackState = .paused
    }
    
    // Stop playback
    func stop() {
        source?.stop()
        playbackState = .stopped
    }
    
    // Play next song in the queue
    func next() {
        guard currentIndex + 1 < queue.count else {
            print("Reached end of queue.")
            return
        }
        currentIndex += 1
        play()
    }
    
    // Play previous song in the queue
    func previous() {
        guard currentIndex > 0 else {
            print("Already at start of queue.")
            return
        }
        currentIndex -= 1
        play()
    }
}

// MARK: - Player ViewModel (MVVM Pattern Simulation)

/// ViewModel class exposing playback info and controls to UI (simulated)
class PlayerViewModel: ObservableObject {
    @Published var songTitle: String = "No Song"
    @Published var songArtist: String = ""
    @Published var playbackState: PlaybackState = .stopped
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let player = MusicPlayer.shared
        
        // Observe playback state changes
        player.$playbackState.sink { [weak self] state in
            DispatchQueue.main.async {
                self?.playbackState = state
                self?.updateSongInfo()
            }
        }.store(in: &cancellables)
        
        updateSongInfo()
    }
    
    // Update song details from current song
    private func updateSongInfo() {
        let player = MusicPlayer.shared
        if let song = player.currentSong {
            songTitle = song.title
            songArtist = song.artist
        } else {
            songTitle = "No Song"
            songArtist = ""
        }
    }
    
    // Playback control actions forwarded to MusicPlayer singleton
    func play() {
        MusicPlayer.shared.play()
    }
    
    func pause() {
        MusicPlayer.shared.pause()
    }
    
    func stop() {
        MusicPlayer.shared.stop()
    }
    
    func next() {
        MusicPlayer.shared.next()
    }
    
    func previous() {
        MusicPlayer.shared.previous()
    }
}
    
// MARK: - Demo Code

// When running in an online playground or test environment,
// uncomment the following block to simulate usage:

/*
func demoMusicPlayer() {
    let player = MusicPlayer.shared
    
    // Add songs to queue (using file URLs simulated)
    player.addToQueue(Song(title: "Song1.mp3", artist: "ArtistA", url: URL(string: "file:///local/song1.mp3")!))
    player.addToQueue(Song(title: "Song2.mp3", artist: "ArtistB", url: URL(string: "file:///local/song2.mp3")!))
    player.addToQueue(Song(title: "Song3.mp3", artist: "ArtistC", url: URL(string: "spotify://track/123")!))
    
    // Start with Local Music Source
    player.setSource(LocalMusicSource())
    print("Set source: LocalMusicSource\n")
    
    player.play()
    sleep(1)  // Simulate time passing
    
    player.next()
    sleep(1)
    
    // Switch to Spotify source mid-playback
    player.setSource(SpotifyMusicSource())
    print("\nSwitched source to SpotifyMusicSource\n")
    
    player.next()
    sleep(1)
    
    player.pause()
    sleep(1)
    
    player.stop()
}

demoMusicPlayer()
*/

