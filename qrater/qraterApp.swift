//
//  qraterApp.swift
//  qrater
//
//  Created by FulFlllY on 8/2/24.
//

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let parameters = SpotifyManager.shared.appRemote.authorizationParameters(from: url);

            if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
                SpotifyManager.shared.appRemote.connectionParameters.accessToken = access_token
                SpotifyManager.shared.setAccessToken(accessToken: access_token)
            } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
                print(error_description)
            }
      return true
    }
}

@main
struct qraterApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
