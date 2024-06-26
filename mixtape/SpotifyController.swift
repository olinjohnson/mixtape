//
//  SpotifyController.swift
//  mixtape
//
//  Created by Olin Johnson on 6/25/24.
//

import Foundation
import SpotifyiOS
import SwiftUI

class SpotifyController {
    
    let SpotifyClientID: String
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    
    init(ClientID: String) {
        self.SpotifyClientID = ClientID
    }
    
}
