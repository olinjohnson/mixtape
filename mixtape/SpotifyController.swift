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
    
    private let keychain = Keychain(service: "com.themixtapeapp.mixtapeapp")
    
    func authorize() {
        
        let authorizationURL = spotify.authorizationManager.makeAuthorizationURL(
            redirectURI: self.redirect_URI,
            showDialog: false,
            state: self.state,
            scopes: [
                .playlistModifyPrivate,
                .userModifyPlaybackState,
                .playlistReadCollaborative,
                .userReadPlaybackPosition,
                .userReadPlaybackState
            ]
        )!
        
        UIApplication.shared.open(authorizationURL)
    }
    
    func deauthorize() {
        self.spotify.authorizationManager.deauthorize()
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
    
    func getAvailableDeviceThenPlay(_ playbackRequest: PlaybackRequest) -> AnyPublisher<Void, Error> {
        
        return self.spotify.availableDevices().flatMap {
            devices -> AnyPublisher<Void, Error> in

            let usableDevices = devices.filter { device in
                !device.isRestricted && device.id != nil
            }

            let device = usableDevices.first(where: \.isActive)
                    ?? usableDevices.first
            
            if let deviceId = device?.id {
                return self.spotify.play(playbackRequest, deviceId: deviceId)
            }
    
            else {
                return SpotifyGeneralError.other(
                    "no active or available devices",
                    localizedDescription:
                    "There are no devices available to play content on. " +
                    "Try opening the Spotify app on one of your devices."
                )
                .anyFailingPublisher()
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    @State private var playbackRequestCancellable: AnyCancellable? = nil
    
    
    
    
    func playCurrentTrack() {
        let playbackRequest = PlaybackRequest(
            context: .contextURI(""),
            offset: nil
        )
        
        self.playbackRequestCancellable = self.getAvailableDeviceThenPlay(playbackRequest)
            .receive(on:RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            })
    }
    
}
 
