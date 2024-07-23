//
//  SpotifyController.swift
//  mixtape
//
//  Created by Olin Johnson on 6/25/24.
//

import Foundation
//import SpotifyiOS
import SwiftUI
import KeychainAccess
import Combine
import SpotifyWebAPI

class SpotifyController: ObservableObject {
    
    init() {
        self.spotify.authorizationManagerDidChange
            .receive(on: RunLoop.main)
            .sink(receiveValue: authManagerChange)
            .store(in: &cancellables)
        self.spotify.authorizationManagerDidDeauthorize
            .receive(on: RunLoop.main)
            .sink(receiveValue: authManagerDeauthorized)
            .store(in: &cancellables)
        
        if let authManagerData = keychain[data: Self.authManagerKey] {
            do {
                let authManager = try JSONDecoder().decode(
                    AuthorizationCodeFlowManager.self,
                    from: authManagerData
                )
                
                self.spotify.authorizationManager = authManager
                
            } catch {
                print("Error decoding authorizationManager from keychain data")
            }
        }
    }
    
    let spotify = SpotifyAPI(
        authorizationManager: AuthorizationCodeFlowManager(
            clientId: SpotifyAuthKeys.client_ID,
            clientSecret: SpotifyAuthKeys.client_secret
        )
    )
    
    static let authManagerKey = "authManager"
    let redirect_URI = URL(string: "mixtape://callback")!
    
    var codeVerifier = String.randomURLSafe(length: 128)
    lazy var codeChallenge = String.makeCodeChallenge(codeVerifier: self.codeVerifier)
    var state = String.randomURLSafe(length: 128)
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isAuthorized = false
    
    private let keychain = Keychain(service: "io.github.olinjohnson.mixtape")
    
    func authorize() {
        
        let authorizationURL = spotify.authorizationManager.makeAuthorizationURL(
            redirectURI: self.redirect_URI,
            showDialog: false,
            state: self.state,
            scopes: [
                .playlistModifyPrivate,
                .userModifyPlaybackState,
                .playlistReadCollaborative,
                .userReadPlaybackPosition
            ]
        )!
        
        UIApplication.shared.open(authorizationURL)
    }
    
    func setAuthTokens(_ url: URL) {
        
        spotify.authorizationManager.requestAccessAndRefreshTokens(
            redirectURIWithQuery: url,
            state: self.state
        )
        .sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    print("Spotify authorization success")
                case .failure(let error):
                    if let authError = error as? SpotifyAuthorizationError, authError.accessWasDenied {
                        print("Spotify authorization denied")
                    }
                    else {
                        print("Error authorizing spotify: \(error)")
                    }
            }
        })
        .store(in: &cancellables)
        
        self.state = String.randomURLSafe(length: 128)
        
    }
    
    func authManagerChange() {
        self.isAuthorized = self.spotify.authorizationManager.isAuthorized()
        
        do {
            let authManagerData = try JSONEncoder().encode(self.spotify.authorizationManager)
            
            keychain[data:Self.authManagerKey] = authManagerData
        } catch {
            print("Error encoding auth manager data to keychain")
        }
    }

    func authManagerDeauthorized() {
        self.isAuthorized = false
        
        do {
            try keychain.remove(Self.authManagerKey)
        } catch {
            print("Error removing authorization manager from keychain")
        }
    }
    
}
 
/*
@MainActor
class SpotifyController: NSObject, ObservableObject {

//    let SpotifyClientID: String = try! Configuration.value(for: "SPOTIFY_CLIENT_ID")
    let SpotifyClientID: String = "66327df3a9b046199b92b090fa93a27e"
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
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
*/
