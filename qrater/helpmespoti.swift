import SpotifyiOS //github 링크 넣을 것
import Foundation


struct SongDetails {
    var title: String
    var artistName: String
    var albumName: String
}

class SpotifyManager: NSObject {
    static let shared = SpotifyManager()
    
    private var accessToken: String?
    
    private let configuration = SPTConfiguration(
        clientID: "541c4ebc3df0441abca87671b29d4964",
        redirectURL: URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    )
    
    var appRemote: SPTAppRemote {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }
    
    private override init() {}
    
    func authrization() {
        self.appRemote.authorizeAndPlayURI("")
    }
    
    func setAccessToken(accessToken: String?) {
        print("AccessToken: \(accessToken ?? "There is no accessToken")")
        self.accessToken = accessToken
    }
    
    func fetchSongs(searchQuery: String, completion: @escaping ([SongDetails]?) -> Void) {
        let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let url = URL(string: "https://api.spotify.com/v1/search?type=track&q=\(query)&limit=10") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let tracks = json["tracks"] as? [String: Any],
                   let items = tracks["items"] as? [[String: Any]] {
                    var songDetailsList = [SongDetails]()
                    for item in items {
                        let title = item["name"] as? String ?? "Unknown title"
                        let album = item["album"] as? [String: Any]
                        let albumName = album?["name"] as? String ?? "Unknown album"
                        let artists = item["artists"] as? [[String: Any]]
                        let artistName = artists?.first?["name"] as? String ?? "Unknown artist"

                        let songDetails = SongDetails(title: title, artistName: artistName, albumName: albumName)
                        songDetailsList.append(songDetails)
                    }
                    completion(songDetailsList)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

extension SpotifyManager: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: (any Error)?) {
        print("")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: (any Error)?) {
        print("")
    }
}
