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

@MainActor
class SpotifyController: NSObject, ObservableObject {

//    let SpotifyClientID: String = try! Configuration.value(for: "SPOTIFY_CLIENT_ID")
    let SpotifyClientID: String = "66327df3a9b046199b92b090fa93a27e"
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback/")!
    
    @Published var connected = false
    
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
            connected = true
        }
    }

    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
            connected = false
        }
    }
    
    func authorize() {
        self.appRemote.authorizeAndPlayURI("")
        connected = true
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
        self.connected = true
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: (any Error)?) {
        print("failed spotify connection with error")//: \(error!)")
        self.connected = false
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: (any Error)?) {
        print("spotify disconnected with error")//: \(error!)")
        self.connected = false
    }
    
}

