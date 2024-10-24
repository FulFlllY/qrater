import Combine
import SpotifyiOS
import Foundation

@MainActor
final class SpotifyManager: NSObject, ObservableObject {
    let spotifyRedirectURL = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
    
    var accessToken: String? = nil
    
    @Published var currentTrackURI: String?
    @Published var currentTrackName: String?
    @Published var currentTrackArtist: String?
    @Published var currentTrackDuration: Int?
    @Published var currentTrackImage: UIImage?
    
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    override init() {
        super.init()
    }
    
    func connect() {
        if let _ = self.appRemote.connectionParameters.accessToken {
            appRemote.connect()
        }
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            print("AccessToken: \(accessToken)")
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Handle the error
            print(errorDescription)
        }
    }
    
    func authorize() {
        if accessToken == nil {
            self.appRemote.authorizeAndPlayURI("")
        }
    }
    
    func play(uri: String) {
        self.appRemote.authorizeAndPlayURI(uri)
    }
    
    func seachArtist(keyword: String) async -> [Artist] {
        let encodedQuery = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchURL = "https://api.spotify.com/v1/search?q=\(encodedQuery)&type=artist"
        
        guard let url = URL(string: searchURL),
              let accessToken = accessToken else {
                print("유효하지 않은 검색 URL")
                return []
            }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let searchArtistResult = try JSONDecoder().decode(SearchArtistResult.self, from: data)
            return searchArtistResult.artists?.items ?? []
        } catch {
            print("SearchArtist: \(error)")
            return []
        }
    }
    
    func searchTrack(keyword: String) async -> [Track] {
        let encodedQuery = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let searchURL = "https://api.spotify.com/v1/search?q=\(encodedQuery)&type=track"
        
        guard let url = URL(string: searchURL),
              let accessToken = accessToken else {
                print("유효하지 않은 검색 URL")
                return []
            }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("SearchTrack: \(String(decoding: data, as: UTF8.self))")
            let searchArtistResult = try JSONDecoder().decode(SearchTrackResult.self, from: data)
            return searchArtistResult.tracks?.items ?? []
        } catch {
            print("SearchTrack: \(error)")
            return []
        }
    }
    
    func requestArtistByID(_ id: String) async -> Artist? {
        let encodedQuery = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.spotify.com/v1/artists/\(encodedQuery)"
        
        guard let url = URL(string: urlString),
              let accessToken = accessToken else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            print(response)
            let artist = try JSONDecoder().decode(Artist.self, from: data)
            return artist
        } catch {
            print("ArtistByID: \(error)")
            return nil
        }
    }
}

extension SpotifyManager: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                print("Error subscribing to player state: \(error.localizedDescription)")
            } else {
                print("Successfully subscribed to player state")
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        // Handle the connection failure
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        // Handle the connection loss
    }
}

extension SpotifyManager: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        self.currentTrackURI = playerState.track.uri
        self.currentTrackName = playerState.track.name
        self.currentTrackArtist = playerState.track.artist.name
        self.currentTrackDuration = Int(playerState.track.duration) / 1000 // playerState.track.duration is in milliseconds
        fetchImage()
    }
    
    func fetchImage() {
        appRemote.playerAPI?.getPlayerState { (result, error) in
            if let error = error {
                print("Error getting player state: \(error)")
            } else if let playerState = result as? SPTAppRemotePlayerState {
                self.appRemote.imageAPI?.fetchImage(forItem: playerState.track, with: CGSize(width: 300, height: 300), callback: { (image, error) in
                    if let error = error {
                        print("Error fetching track image: \(error.localizedDescription)")
                    } else if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.currentTrackImage = image
                        }
                    }
                })
            }
        }
    }
}
