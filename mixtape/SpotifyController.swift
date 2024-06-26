//
//  SpotifyController.swift
//  mixtape
//
//  Created by Olin Johnson on 6/25/24.
//

import Foundation
import SpotifyiOS
import SwiftUI
import Combine


class SpotifyController: NSObject, ObservableObject {

    let SpotifyClientID: String = try! Configuration.value(for: "SPOTIFY_CLIENT_ID")
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
    var accessToken: String? = nil
    
    var playURI = ""
    
    private var connectCancellable: AnyCancellable?
    private var disconnectCancellable: AnyCancellable?

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("error initializing accesss token: \(errorDescription)")
        }
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
    
    override init() {
        super.init()
        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.connect()
            }
        
        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.disconnect()
            }
    }

}

extension SpotifyController: SPTAppRemoteDelegate {
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("spotify connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: (any Error)?) {
        print("failed spotify connection with error")//: \(error!)")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: (any Error)?) {
        print("spotify disconnected with error")//: \(error!)")
    }
    
}
